//
//  SideMenu.swift
//  Insurtech
//
//  Created by Taimoor Arif on 09/05/2022.
//

import SwiftUI

struct SideMenu: View {
    
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
    var onClick: (_ selectedView: NavViews) -> Void
    
    var body: some View {
        
        ZStack {
            
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.2))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.menuClose()
            }
            GeometryReader { geometry in
                HStack {
                    SideMenuView(menuClose: menuClose, onClick: onClick)
                        .frame(width: geometry.size.width * 0.70)
                        .offset(x: self.isOpen ? 0 : -self.width)
                        .animation(.default)
                        
                    Spacer()
                }
            }
            
    
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
    }
}


