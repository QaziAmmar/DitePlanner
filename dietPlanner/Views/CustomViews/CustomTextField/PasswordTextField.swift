//
//  PasswordTextField.swift
//  Unified
//
//  Created by Qazi Ammar Arshad on 07/07/2022.
//

import SwiftUI

struct PasswordTextField: View {
    var title = ""
    var placeHolder = ""
    @Binding var text: String
    @State var isSecure = true
    @FocusState private var isFocused: Bool

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.custom(Nunito.Medium.rawValue, size: 13))
                .padding(.bottom, 5)
            ZStack(alignment: .trailing) {

                Group {
                    isSecure ? AnyView(secureTF()) : AnyView( normalTF())
                }

                Button {
                    isSecure.toggle()
                } label: {
                    Image(isSecure ? ImageName.show.rawValue : ImageName.hide.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .padding(.trailing)
                }
            }
        }
    }

    func secureTF() -> some View {

        SecureField(placeHolder, text: $text)
            .font(.custom(Nunito.Regular.rawValue, size: 13))
            .focused($isFocused)
            .padding(15)
            .foregroundColor(Color.black)
            .background(.white)
            .cornerRadius(8)
            .frame( height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                 .stroke(isFocused ? Color(ColorName.appGreen.rawValue) :
                         .gray , lineWidth: 1)
                    .transition(.opacity)
            )

    }

    func normalTF() -> some View {
        TextField(placeHolder, text: $text)
            .font(.custom(Nunito.Regular.rawValue, size: 13))
             .padding(15)
             .focused($isFocused)
             .background(.white)
             .foregroundColor(Color.black)
             .cornerRadius(8)
             .frame( height: 50)
             .overlay(
                RoundedRectangle(cornerRadius: 8)
                 .stroke(isFocused ? Color(ColorName.appGreen.rawValue) :
                         .gray , lineWidth: 1)
                    .transition(.opacity)
             )
    }
}

struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField(text: .constant("123"))
    }
}
