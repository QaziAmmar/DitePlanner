//
//  CustomTextField.swift
//  BWR Covid-19 Test
//
//  Created by Ammar on 2/5/22.
//

import SwiftUI

struct CustomTextField: View {
    
    var title = ""
    @FocusState var isFocused: Bool
    @State private var editing = false
    var placeHolder = String()
    @Binding var text: String
    var isSecure = false
    var background: Color = .white
    
    var body: some View {
        Group {
            isSecure ? AnyView(secureTF()) : AnyView( normalTF())
        }
        
    }
    
    func secureTF() -> some View {
        SecureField(placeHolder, text: $text)
            .font(.custom(Roboto.Regular.rawValue, size: 14))
            .focused($isFocused)
            .padding(20)
            .background(background)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color(ColorName.appGreen.rawValue) :
                            .gray , lineWidth: 1)
            )
    }
    
    func normalTF() -> some View {
        TextField(placeHolder, text: $text)
            .font(.custom(Roboto.Regular.rawValue, size: 14))
            .padding(20)
            .focused($isFocused)
        
            .background(background)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color(ColorName.appGreen.rawValue) :
                            .gray , lineWidth: 1)
            )
    }
    
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""))
    }
}
