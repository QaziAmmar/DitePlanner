//
//  LoginViewModel.swift
//  HTPlanner
//
//  Created by Qazi Ammar Arshad on 03/06/2022.
//

import Foundation
import FirebaseAuth
import SwiftSpinner


class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var showError = false
    var errorMessage = ""
    
    private func validationCheck() -> Bool {
        
        if password.isEmpty || email.isEmpty {
            showError(message: "Please fill all the fields")
            return false
        }
        
        if password.count < 6 {
            showError(message: "Password must be at least 6 characters")
            return false
        }
        
        if !Validator.shared.isValidEmail(email: email) {
            showError(message: "Email is not valid")
            return false
        }
        
        return true
        
    }
    
    
    func login() {

        /// If any validation does not satisfied.
        if !validationCheck() {
            return
        }
        
        SwiftSpinner.show("Loading...")
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            
            guard authResult != nil, error == nil else {
                SwiftSpinner.hide()
                print(error?.localizedDescription ?? "no error")
                self?.showError(message: error?.localizedDescription ?? "HTPlanner Login Error")
                
                return
            }
            
            self?.readUserFromDataBase(firebaseID: (authResult?.user.uid)!)
            
        })
        
    }
    
    func readUserFromDataBase(firebaseID: String) {
        
        FirebaseDatabaseManager.shared.getUser(with: firebaseID) { (success, message) in
            
            if !success {
                self.showError(message: message)
            } else {
                // this is a broadcast message which chagen your root
                print("change root of the application")
                
                UserDefaultManager.Authenticated.send(true)
            }
            SwiftSpinner.hide()
        }
        
    }
    
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }
    
    
}
