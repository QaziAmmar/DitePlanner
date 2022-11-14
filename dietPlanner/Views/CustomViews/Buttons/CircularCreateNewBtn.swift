//
//  CircularCreateNewBtn.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 03/11/2022.
//

import SwiftUI

struct CircularCreateNewBtn: View {
    
    var action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            HStack {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
            }.padding(25)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: "76E9E5"), Color(hex: "00A7A1")]), startPoint: .leading, endPoint: .trailing)
                        .clipShape(Circle())
                )
        }
    }
}

struct CircularCreateNewBtn_Previews: PreviewProvider {
    static var previews: some View {
        CircularCreateNewBtn(action: {
            print("create new btn clicked")
        })
    }
}
