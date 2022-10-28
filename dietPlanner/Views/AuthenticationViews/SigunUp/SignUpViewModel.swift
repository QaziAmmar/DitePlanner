//
//  LoginVM.swift
//  dietPlanner
//
//  Created by Aqsa's on 04/10/2022.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseDatabase
import FirebaseDatabaseSwift

struct UserModel {
    var fireBaseId: String
    var userName: String
    var userEmail: String
    
}


import Foundation
import FirebaseAuth
import SwiftSpinner
import FirebaseDatabase

class SignUpViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var password = ""
    @Published var email = ""
    @Published var re_password = ""
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    @Published var moveToPreferenceView = false
    
    
    
    private func validationCheck() -> Bool {
        
        if password.isEmpty || name.isEmpty || email.isEmpty {
            showError(message: "Please fill all the fields")
            return false
        }
        
        if password.count < 6 {
            showError(message: "Password must be at least 6 characters")
            return false
        }
        
        if password != re_password {
            showError(message: "Password and retype password does not match")
            return false
        }
        
        if !Validator.shared.isValidEmail(email: email) {
            showError(message: "Email is not valid")
            return false
        }
        
        return true
        
    }
    
    
    func createUser() {
        
        // if field validation does not work the return from this function
        if !validationCheck() {
            return
        }
        
        SwiftSpinner.show("Loading...")
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self]
                        authResult, error in
                        
                        guard authResult != nil, error == nil else {
                            SwiftSpinner.hide()
                            print(error?.localizedDescription ?? "no error")
                            self?.showError(message: error?.localizedDescription ?? "email already exist")
                            return
                        }
            self?.saveIntoDatabase(fireBaseId: authResult?.user.uid ?? "")
            
        })
    }
    
    func saveIntoDatabase(fireBaseId: String) {
        
        let user = User(userName: self.name, firebaseID: fireBaseId, userEmail: self.email, password: self.password)
        
        FirebaseDatabaseManager.shared.insertUser(with: user) { (status, message) in
            
            SwiftSpinner.hide()
            
            switch status {
            case .success:
                // navigation to set dite preference
                UserDefaultManager.shared.set(user: user)
                self.moveToPreferenceView = true
            case .alreadyExist:
                print("success in uploading on real time")
                UserDefaultManager.shared.set(user: user)
                UserDefaultManager.Authenticated.send(true)

            case .fail:
                self.showError = true
                self.errorMessage = message
                
            }
        }
    }
    
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }
    

}
