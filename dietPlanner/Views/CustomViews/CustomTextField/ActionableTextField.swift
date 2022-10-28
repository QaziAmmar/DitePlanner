//
//  ActionableTextField.swift
//  myMufti
//
//  Created by Qazi Ammar Arshad on 04/07/2022.
//

import SwiftUI

struct ActionableTextField: View {
    var placeHolder = String()
    var image = ""
    var title = ""
    @Binding var text: String
    var action: () -> Void
    @FocusState private var isFocused: Bool

    var body: some View {
        normalTF()
    }

    func normalTF() -> some View {

        VStack(alignment: .leading, spacing: 0) {

            Text(title)
                .font(.custom(Nunito.Medium.rawValue, size: 13))
                .padding(.bottom, 5)

            ZStack(alignment: .trailing) {
                TextField(placeHolder, text: $text)
                    .font(.custom(Nunito.Medium.rawValue, size: 13))
                     .padding(15)
                     .focused($isFocused)
                     .disabled(true)
                     .foregroundColor(Color.black)
                     .frame(height: 56)
                     .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(isFocused ? Color(ColorName.appGreen.rawValue) :
                                    .gray , lineWidth: 1)
                     )

                Button {
                    self.action()
                } label: {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .padding()
                }

            }
        }
    }

}

struct ActionableTextField_Previews: PreviewProvider {
    static var previews: some View {
        ActionableTextField(placeHolder: "Placeholder", image: ImageName.show.rawValue, text: .constant("parameters"), action: {
            print("helper")
        })
    }
}
