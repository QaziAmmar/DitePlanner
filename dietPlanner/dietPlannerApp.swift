//
//  dietPlannerApp.swift
//  dietPlanner
//
//  Created by Aqsa's on 15/09/2022.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

    
    
    @main
    struct dietPlannerApp: App {
        
        @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
        
        var body: some Scene {
            WindowGroup {
                
                // Walk Through screen will be seen only once.
                NavigationView {
                    if UserDefaultManager.shared.isWalkThrougViewed() {
                        HideNavbarOf(view: ContentView())
                    } else {
                            HideNavbarOf(view: WelcomeView())
                        }
                    }
            }
        }
    }

