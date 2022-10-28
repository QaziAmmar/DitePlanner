//
//  RedBtn.swift
//  HTPlanner
//
//  Created by Qazi Ammar Arshad on 07/10/2022.
//

import SwiftUI

struct RedBtn: View {
    var action: () -> Void
    var title: String
    
    var body: some View {
        Button {
            self.action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .foregroundColor(.red.opacity(0.85))
                Text(title)
                    .foregroundColor(.white)
                    .font(Font.custom(Roboto.Medium.rawValue, size: 20))
            }
        }

    }
}
struct RedBtn_Previews: PreviewProvider {
    static var previews: some View {
        RedBtn(action: {
            print("")
        }, title: "Delete Account")
    }
}
