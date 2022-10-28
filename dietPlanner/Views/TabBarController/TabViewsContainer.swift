//
//  TabBarManager.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 09/03/2022.
//

import SwiftUI

struct TabViewsContainer<Content: View>: View {
    
    var view: Content
    
    
    var body: some View {
        NavigationView {
            
            view
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
        // if you did't add this line of code. you navigation controller start working automatically without
        // any reason. 
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TabBarManager_Previews: PreviewProvider {
    static var previews: some View {
        TabViewsContainer(view: EmptyView())
    }
}
