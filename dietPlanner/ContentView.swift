//
//  ContentView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 21/10/2022.
//

import SwiftUI


struct ContentView: View {
    
    @State var isAuthenticated = UserDefaultManager.IsAuthenticated()
    
    var body: some View {
        
        Group {
            // if isAuthenticated then move to tabBarController
            isAuthenticated ? AnyView(TabBarControllerView()) :

            AnyView(
                NavigationView {
                    HideNavbarOf(view: LoginView())
                }
            )
            
        }.onReceive(UserDefaultManager.Authenticated, perform: { newValue in
            isAuthenticated = newValue
        })
        //        .onAppear {
        //            NotificationManger.standard.requestPremission()
        //        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

