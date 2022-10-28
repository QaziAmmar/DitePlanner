//
//  CustomText.swift
//  HTPlanner
//
//  Created by Qazi Ammar Arshad on 27/05/2022.
//

import SwiftUI

struct RobotoCondensedText: View {
    
    var size = 24.0
    var text = /*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/
    var body: some View {
        Text(text)
//            .foregroundColor(.white)
            .font(Font.custom(Roboto.Regular.rawValue, size: size))
    }
}

struct RobotoText: View {
    
    var size = 24.0
    var text = /*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/
    var body: some View {
        Text(text)
//            .foregroundColor(.white)
            .font(Font.custom(Roboto.Regular.rawValue, size: size))
    }
}



struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        RobotoCondensedText()
            .background(Color.black)
    }
}
