//
//  NavbarHiddenView.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 10/03/2022.
//

import SwiftUI

struct HideNavbarOf<Content: View>: View {
    var view: Content
    
    var body: some View {
        view
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

struct NavbarHiddenView_Previews: PreviewProvider {
    static var previews: some View {
        HideNavbarOf(view: EmptyView())
    }
}

