//
//  ChangePasswordViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 27/10/2022.
//

import Foundation
import UIKit
import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation

class ChangePasswordViewModel: ObservableObject {
    
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    // this is for the user of generating the preview
    @Published var user = UserDefaultManager.shared.getUser() ?? User(userName: "Fail to fetch user info", firebaseID: "1", userEmail: "fail@gmail.com", password: "Shimar")
    
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var retypePassword = ""
    
    // Firebase Variable

    let userTable = FireBaseTable.users.rawValue
    
}

// MARK: Custom Function Extension
extension ChangePasswordViewModel {
    
    // show error
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }
    
    
    private func validationCheck() -> Bool {
        
        if newPassword.count < 6 {
            showError(message: "Password must be at least 6 characters")
            return false
        }
        
        if oldPassword != user.password {
            showError(message: "Old Password does't match")
            return false
        }
        
        if newPassword != retypePassword {
            showError(message: "new password and confirm password does't match")
            return false
        }
        
        return true
        
    }
    
}


// MARK: Firebase Model
extension ChangePasswordViewModel {
    
    func updateuser() {

        if !validationCheck() {
            return
        }
        
        self.user.password = self.newPassword
        
        FirebaseDatabaseManager.shared.updateUser(with: self.user) { status, error in
            if status {
                // update the local users defaults
                UserDefaultManager.shared.set(user: self.user)
                
                self.newPassword = ""
                self.oldPassword = ""
                self.retypePassword = ""
                
                self.showError(message: "Password updated successfully")
            } else {
                self.showError(message: error)
            }
        }
        
    }
}
