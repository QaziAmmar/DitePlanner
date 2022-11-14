//
//  EditProfileViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 27/10/2022.
//

import UIKit
import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation

class EditProfileViewModel: ObservableObject {
    
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    // this is for the user of generating the preview
    @Published var user = UserDefaultManager.shared.getUser() ?? User(userName: "Fail to fetch user info", firebaseID: "1", userEmail: "fail@gmail.com", password: "Shimar")
    
    // Firebase Variable

    let userTable = FireBaseTable.users.rawValue
    
}

// MARK: Custom Function Extension
extension EditProfileViewModel {
    
    // show error
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }

    // update user Image
    func updateProfile(profile: UIImage) {
    
        guard let convertedImg = profile.resizedTo1MB()?.jpegData(compressionQuality : 0.1) else {
            print("image not converted or found")
            return
        }

        // first upload the image
        StorageManager().uploadProfilePicture(with: convertedImg, table: .users, completion: { status, path in

            switch status {

            case true:
                self.user.image_url = path
                // upload the data
                FirebaseDatabaseManager.shared.updateUser(with: self.user) { status, error in
                    if status {
                        // update the local users defaults
                        UserDefaultManager.shared.set(user: self.user)
                    }
                }

            case false:
                // this path will also contains the error
                print(path)
                self.showError(message: path)
//                complection(false, path)
            }

        })
        
    }
    
    
    func updateuser(complection: @escaping () -> ()) {
        
        FirebaseDatabaseManager.shared.updateUser(with: self.user) { status, error in
            if status {
                // update the local users defaults
                UserDefaultManager.shared.set(user: self.user)
                complection()
            } else {
                self.showError(message: error)
            }
        }
        
    }

}
