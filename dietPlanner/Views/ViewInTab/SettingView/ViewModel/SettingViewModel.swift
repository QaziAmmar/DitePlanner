//
//  SettingViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 16/11/2022.
//

import Foundation
import FirebaseAuth
import SwiftSpinner
import FirebaseDatabase

class SettingViewModel: ObservableObject {
    
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false

    func removeUser() {

        SwiftSpinner.show("Loading...")
        
        let user = FirebaseAuth.Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                SwiftSpinner.hide()
              // An error happened.
                print(error.localizedDescription)
                self.showError(message: error.localizedDescription)
            } else {
              // Account deleted.
                self.removeUserFromDatabase(fireBaseId: user?.uid ?? "")
            }
        }
       
    }
    private func removeUserFromDatabase(fireBaseId: String) {
        

        FirebaseDatabaseManager.shared.deleteUser(with: fireBaseId) { (success, message) in
            if !success {
                self.showError(message: message)
            } else {
                UserDefaultManager.shared.logout()
            }
            
            SwiftSpinner.hide()
        }
    }
    
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }
    
    
    
}
