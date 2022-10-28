//
//  CustomHeartCheckView.swift
//  dietPlanner
//
//  Created by Aqsa's on 23/09/2022.
//

import SwiftUI

struct CustomHeartCheckView: View {
    
    @Binding var ischeck: Bool
    
    var body: some View {
        
        Button(action: {
            ischeck.toggle()
        }, label: {
            
            if ischeck {
                Image(Heart.heartFill.rawValue)
                                .resizable()
                                .frame(width: 20, height: 20)
            } else {
                Image(Heart.heart.rawValue)
                                .resizable()
                                .frame(width: 20, height: 20)
            }
            
        })
        
    }
}

struct CustomHeartCheckView_Previews: PreviewProvider {
    static var previews: some View {
        CustomHeartCheckView(ischeck: .constant(true))
    }
}

