//
//  SignInViewModel.swift
//  dietPlanner
//
//  Created by Aqsa's on 10/10/2022.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift

class SignInViewModel: ObservableObject {
    @Published var moveToNext = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firebaseId: String = ""
     var user: UserStore = UserStore()
    private let ref = Database.database().reference()
    
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                print("Logged in Successfully")
                
                self.firebaseId = result?.user.uid ?? ""

                UserDefaults.standard.set(self.firebaseId, forKey: "FireBaseId")
                self.moveToNext = true

                
            }
            
        }
    }
}
