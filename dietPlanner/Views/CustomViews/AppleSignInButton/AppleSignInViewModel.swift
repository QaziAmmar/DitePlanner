//
//  AppleSignInViewModel.swift
//  HTPlanner
//
//  Created by Qazi Ammar Arshad on 06/10/2022.
//

import Foundation

import UIKit
import AuthenticationServices
import Foundation
import SwiftUI
import GoogleSignIn
import SwiftSpinner
import FirebaseAuth
import FirebaseDatabase

class AppleSignInViewModel: ObservableObject {
    
    @Published var givenName: String = ""
    @Published var email: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    var appleProvider = AppleSignIn()
    
    func signIn() {
        
        appleProvider.handleAppleIdRequest(block: {fullname, email, token, idTokenString  in
            
            self.givenName = fullname ?? ""
            self.email = email ?? ""
            
            self.socialFirebaseAuth(idToken: idTokenString ?? "")
            
        })
    }
    
    
}


// MARK: FireBase Extension
extension AppleSignInViewModel {
    
    
    private func socialFirebaseAuth(idToken: String) {
        
        
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idToken,
                                                  rawNonce: nil)
        
        FirebaseAuth.Auth.auth().signIn(with: credential) { authResult, error in
            
            guard authResult != nil, error == nil else {
                //                self.showErrorFunc(message: error?.localizedDescription ?? "Email already")
                print(error?.localizedDescription ?? "Email already exist")
                return
            }
            
            let fbaseId = authResult?.user.uid ?? ""
            
            let chatUser = User(userName: self.givenName, firebaseID: fbaseId, userEmail: self.email, password: SOCIAL_PASSWORD)
            
            FirebaseDatabaseManager.shared.insertUser(with: chatUser) { status, error in
                
                SwiftSpinner.hide()
                
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
    
    
    func showErrorFunc(message: String ) {
        self.showError = true
        self.errorMessage = message
    }
    
}




class AppleSignIn: NSObject {
    var completionHandler: (_ fullname: String?, _ email: String?, _ token: String?, _ idTokenString: String?) -> Void = { _, _, _ , _ in }
    
    @available(iOS 13.0, *) // sign in with apple is not available below iOS13
    @objc func handleAppleIdRequest(block: @escaping (_ fullname: String?, _ email: String?, _ token: String?, _ idTokenString: String?) -> Void) {
        completionHandler = block
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    @available(iOS 13.0, *) // sign in with apple is not available below iOS13
    func getCredentialState(userID: String) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) { credentialState, _ in
            switch credentialState {
            case .authorized:
                // The Apple ID credential is valid.
                break
            case .revoked:
                // The Apple ID credential is revoked.
                break
            case .notFound:
                // No credential was found, so show the sign-in UI.
                break
            default:
                break
            }
        }
    }
}

@available(iOS 13.0, *)
extension AppleSignIn: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            //            getting user details
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let token = userIdentifier
            print("User id is \(token) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
            
            
            if let identityTokenData = appleIDCredential.identityToken,
               let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
                print("Identity Token \(identityTokenString)")
                completionHandler(fullName?.givenName, email, token, identityTokenString)
            } else {
                completionHandler(fullName?.givenName, email, nil, nil)
            }
            
            getCredentialState(userID: userIdentifier)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("error in sign in with apple: \(error.localizedDescription)")
    }
}
