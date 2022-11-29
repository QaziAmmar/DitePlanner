//
//  WebServices.swift
//  Qarinli
//
//  Created by Abdur Rauf on 08/09/2020.
//  Copyright © 2020 Abdur Rauf. All rights reserved.

import Foundation
import Alamofire
import SwiftSpinner

var showAPILoader = true

class NetworkManager {
    
    static let shared = NetworkManager()
    
    typealias apiSuccess = (_ data: Codable , _ statusCode : Int) -> Void
    typealias apiFailure = (_ errorString: String) -> ()

    static let baseUrl = "https://world.openfoodfacts.org/api/v0/product/"
    static let mediaURL = "http://rap.bitzstudio.com/"
    
    private func getHeaders () -> HTTPHeaders?{
        
        var header : HTTPHeaders?
        // user's Defaults are empty then call if methos
        header = [HTTPHeaderKEYS.Accept.rawValue : "application/json"]
        return header
    }

    /// Server is sending us the half image URL, so we need to append the base URL before the Image URL
    func getCompleteImageURL(img_url: String) -> String {
        return NetworkManager.mediaURL + img_url
    }
}

extension NetworkManager{
    
    
    func URLrequest<T : Codable>(productId:String, methodType: HTTPMethod, parametres :[String:Any]? = nil, returnType:T.Type,  withSuccess success: @escaping apiSuccess, withapiFiluer failure: @escaping apiFailure ){
        
        
        let url =  NetworkManager.baseUrl + productId + ".json"
        let headers : HTTPHeaders? = getHeaders()
        
        
        SwiftSpinner.show("Finding Product")
        
        AF.request(url, method: methodType, parameters: parametres, encoding: JSONEncoding.default, headers:headers).validate(statusCode: 200..<600).responseData(completionHandler: {   respone in
            
            SwiftSpinner.hide()
            
            switch respone.result {
                
            case .success(let value):

                print(url)

                let statusCode = respone.response?.statusCode ?? 0
         
                    do{
                        let decoder = JSONDecoder()
                        print(String(data: value, encoding: .utf8))
                        let parsedObject =  try decoder.decode(returnType.self, from: value)
                        success(parsedObject, statusCode)
                    } catch let error {
                         print(error)
                        failure(error.localizedDescription)
                    }
                
            case .failure(let error):
                print(error.localizedDescription)
                failure(error.localizedDescription)
                
//                self.hideProgressBar()
            }
        })
        
    }
    
}

