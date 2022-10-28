//
//  RedButton.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 07/03/2022.
//

import SwiftUI

struct SecondaryBtn: View {
    
    var action: () -> Void
    var title: String
    
    var body: some View {
        Button {
            self.action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
//                    .stroke(Color(ColorName.titleColor.rawValue), lineWidth: 1)
                    .frame(height: 50)

                Text(title)
//                    .foregroundColor(Color(ColorName.titleColor.rawValue))
                    .font(.custom(Roboto.Medium.rawValue, size: 14))
                    
            }
        }

    }
}

struct RedButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryBtn(action: {
            print("ammar is called")
        }, title: "Cancel")
    }
}
