//
//  DropDownBtn.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 27/06/2022.
//

import SwiftUI

struct DropDownBtn: View {

    var text = ""
    var image = "ImageName.dropDownIcon.rawValue"
    var action: (() -> Void)?

    var body: some View {
       loadView()
    }
}

extension DropDownBtn {
    func loadView() -> some View {
        HStack {
            Text(text)
                .foregroundColor(.gray)
                .padding()

            Spacer()

            Button {
                action!()
            } label: {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }.padding(10)

        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray)
        )
    }
}

struct DropDownBtn_Previews: PreviewProvider {
    static var previews: some View {
        DropDownBtn()
    }
}
