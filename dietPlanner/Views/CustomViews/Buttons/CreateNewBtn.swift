//
//  SwiftUIView.swift
//  HTPlanner
//
//  Created by Qazi Ammar Arshad on 08/08/2022.
//

import SwiftUI

struct CreateNewBtn: View {

    var action: () -> Void
    
    var body: some View {
        Button {
            self.action()
        } label: {
            HStack {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .frame(width: 20, height: 20)
            }.padding(20)
              
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(ColorName.appGreen.rawValue))
            )
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewBtn {
            print("create new button")
        }
    }
}
