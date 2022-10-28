//
//  YellowBtn.swift
//  HTPlanner
//
//  Created by Qazi Ammar Arshad on 27/05/2022.
//

import SwiftUI

struct GreenBtn: View {
    var action: () -> Void
    var title: String
    
    var body: some View {
        Button {
            self.action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .foregroundColor(Color(ColorName.appGreen.rawValue))
                Text(title)
                    .foregroundColor(.white)
                    .font(Font.custom(Nunito.Bold.rawValue, size: 20))
            }
        }

    }
}

struct YellowBtn_Previews: PreviewProvider {
    static var previews: some View {
        GreenBtn(action: {
            print("ammar is called")
        }, title: "Sign Up")
    }
}

