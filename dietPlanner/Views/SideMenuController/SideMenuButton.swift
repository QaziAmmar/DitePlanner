//
//  SideMenuButton.swift
//  Insurtech
//
//  Created by Taimoor Arif on 07/05/2022.
//

import SwiftUI

struct SideMenuButton: View {
    
    var image: String
    var title: String
    
    var body: some View {

                
                HStack{
                    
                    Image(image)
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    Text(title)
                        .foregroundColor(.white)
//                        .font(.custom(InterFont.semiBold.rawValue, size: 14))
                    
                    Spacer()
                    
                    
                }.padding(10)
            
    }
}

struct SideMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuButton(image: "home", title: "account")
    }
}
