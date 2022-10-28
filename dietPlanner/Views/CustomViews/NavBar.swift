//
//  NavBar.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 07/03/2022.
//

import SwiftUI

struct NavBar: View {
    
    var action: () -> Void
    var title = ""
    var image: String?
    
    var body: some View {
        HStack {
            Button {
                self.action()
            } label: {
                
                Image( image == nil ? "back": image!)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color(ColorName.appGreen.rawValue))
            }
            .frame(width: 50, height: 50)
            Spacer()
            Text(title)
                .font(Font.custom(Nunito.Bold.rawValue, size: 22))
                .offset(x: -16)
                .foregroundColor(Color(ColorName.appGreen.rawValue))
            Spacer()
        }.padding([.trailing, .bottom])
            
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(action: {
            print("back btn")
        }, title: "Setting", image: "Drawer")
    }
}
