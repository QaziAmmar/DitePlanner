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
    
    @Published var totalCalories = 0
    @Published var consumedCalories = 0

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
    
    
    func caloriesConsumedPercentage() -> Double {
        return Double(consumedCalories) / Double(totalCalories)
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
    
    func readGoald()  {
        let goals = UserDefaultManager.shared.getGoal(type: DAILY)
        if goals.calories == 0.0 {
            print("no goal is set")
        }
    }
    
    
    
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }
    
    
    
}
