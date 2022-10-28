//
//  StorageMangers.swift
//  dietPlanner
//
//  Created by Aqsa's on 17/10/2022.
//

import Foundation
import FirebaseStorage
import SwiftSpinner

class StorageManager {
    
    static let shared = StorageManager()
    
    let storage = Storage.storage().reference()
    
    public func uploadProfilePicture(with data: Data, table: FireBaseTable, completion: @escaping (Bool, String) -> Void) {
        
        SwiftSpinner.show("uploading image...")
        
        let path = generateImageName(table: table)
        let storageRef = storage.child(path)
        
        storageRef.putData(data, metadata: nil, completion: { metadata, error in
            SwiftSpinner.hide()
            
            if error != nil  {
                // Uh-oh, an error occurred!
                print(error?.localizedDescription ?? "")
                completion(false, error?.localizedDescription ?? "fail to upload recipe image on server")
                return
            }
            // get the downloadable url for the image
            storageRef.downloadURL { url, error in
                print(url?.absoluteString ?? "")
                completion(true, url?.absoluteString ?? "recipe url fail")
            }
            
        })
    }
    
    
    private func generateImageName(table: FireBaseTable) -> String {
        return  table.rawValue + "/" +  UUID().uuidString + ".png"
    }
    
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = Storage.storage().reference().child(path)
        print("path is \(path)")
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                print(error?.localizedDescription ?? "error")
                completion(.failure(StorageErrors.failedToGetDownloadUrl))
                return
            }
            
            completion(.success(url))
        })
    }
    
    
    
}

public enum StorageErrors: Error {
    case failedToUpload
    case failedToGetDownloadUrl
}

