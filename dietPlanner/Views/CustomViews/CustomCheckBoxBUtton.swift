//
//  CustomCheckBoxView.swift
//  dietPlanner
//
//  Created by Aqsa's on 28/09/2022.
//

import SwiftUI

import SwiftUI

struct CustomCheckBoxButton: View {
    
    @Binding var ischeck: Bool
    
    var body: some View {
        
        Button(action: {
            ischeck.toggle()
        }, label: {
            
            if ischeck {
                Image("check")
                                .resizable()
                                .frame(width: 24, height: 24)
            } else {
                Rectangle()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.white)
                    .overlay(Rectangle().stroke(Color.gray, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/))
            }
            
        })
        
    }
}

struct CustomCheckBoxButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomCheckBoxButton(ischeck: .constant(true))
    }
}
