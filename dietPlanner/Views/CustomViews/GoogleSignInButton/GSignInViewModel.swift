//
//  GsignInViewModel.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 18/03/2022.
//

import Foundation
import SwiftUI
import GoogleSignIn
import SwiftSpinner
import FirebaseAuth
import FirebaseDatabase


class GSignInViewModel: ObservableObject {

    @Published var givenName: String = ""
    @Published var email: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    func checkStatus(){
        
        SwiftSpinner.show("Loading...")
        
        if(GIDSignIn.sharedInstance.currentUser != nil){
        
            let user = GIDSignIn.sharedInstance.currentUser
            guard let user = user else { return }

            self.givenName = user.profile?.name ?? ""
            self.email = user.profile?.email ?? ""
//            createUser()
            self.socialFirebaseAuth(user: user)

        } else {
            SwiftSpinner.hide()
            self.isLoggedIn = false
            self.givenName = "Not Logged In"
//            self.profilePicUrl =  ""
            print("Not Logged In")
        }
    }
    
    
    
    
    func signIn(){

       guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}

        let signInConfig = GIDConfiguration.init(clientID: "1030481645632-7666a818pdgusmubdqg3rtak81s8nevq.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(
            with: signInConfig,
            presenting: presentingViewController)
             { user, error in
                if let error = error {
                    self.errorMessage = "error: \(error.localizedDescription)"
                }
                self.checkStatus()
            }
        
    }

    func signOut(){
        GIDSignIn.sharedInstance.signOut()
        self.checkStatus()
    }
}

// MARK: FireBase Extension
extension GSignInViewModel {
    
    func createUser() {
        
        SwiftSpinner.show("Loading...")

        FirebaseAuth.Auth.auth().createUser(withEmail: self.email, password: "123456", completion: { [weak self]
                        authResult, error in
                        
                        guard authResult != nil, error == nil else {
                            SwiftSpinner.hide()
                            print(error?.localizedDescription ?? "email already exist")
                            // login
                            self?.login()
                            return
                        }
            self?.saveIntoDatabase(fireBaseId: authResult?.user.uid ?? "")
            
        })
    }
    
    private func socialFirebaseAuth(user: GIDGoogleUser) {
        
        SwiftSpinner.show("loading...")
        let authentication = user.authentication
        let idToken = authentication.idToken ?? ""
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
        
        FirebaseAuth.Auth.auth().signIn(with: credential) { authResult, error in
            
            guard authResult != nil, error == nil else {
//                self.showError(message: error?.localizedDescription ?? "Email already")
                print(error?.localizedDescription ?? "Email already exist")
                return
            }
            
            let fbaseId = authResult?.user.uid ?? ""
            
            let chatUser = User(userName: user.profile?.name ?? "", firebaseID: fbaseId, userEmail: user.profile?.email ?? "", password: SOCIAL_PASSWORD)
            
            FirebaseDatabaseManager.shared.insertUser(with: chatUser) { status, error in
                
                switch status {
                case .success:
                    print("move to preference view")
                case .alreadyExist:
                    print("success in uploading on real time")
                    UserDefaultManager.shared.set(user: chatUser)
                    UserDefaultManager.Authenticated.send(true)
                    
                    
                case .fail:
                    print("failed to upload on real time")
                    print(error)
                    
                }
            }
        }
    }
    
    
    func saveIntoDatabase(fireBaseId: String) {
        
        let user = User(userName: self.givenName, firebaseID: fireBaseId, userEmail: self.email, password: SOCIAL_PASSWORD)
        
        FirebaseDatabaseManager.shared.insertUser(with: user) { (status, message) in
            
            SwiftSpinner.hide()
            
            switch status {
            case .success:
                print("move to preference view")
                
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
    
    
    func login() {

        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: "123456", completion: { [weak self] authResult, error in
            
            guard authResult != nil, error == nil else {
                SwiftSpinner.hide()
                print(error?.localizedDescription ?? "no error")
                self?.errorMessage = "Google Auth issue"
                self?.showError = true
                return
            }
            
            self?.readUserFromDataBase(firebaseID: (authResult?.user.uid)!)
        })
        
    }
    
    func resetPassword() {
      
    }
    
    
    func readUserFromDataBase(firebaseID: String) {
        
        FirebaseDatabaseManager.shared.getUser(with: firebaseID) { (success, message) in

            if !success {
                self.showErrorFunc(message: message)
                
            } else {
                UserDefaultManager.Authenticated.send(true)
            }
            SwiftSpinner.hide()
        }
        
    }
    
    func showErrorFunc(message: String ) {
        self.showError = true
        self.errorMessage = message
    }
   
}

