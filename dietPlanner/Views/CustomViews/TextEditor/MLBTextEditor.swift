//
//  MLBTextEditor.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 25/10/2022.
//

import SwiftUI

struct MLBTextEditor: View {
    
    var title: String
    var text: Binding<String>
    var placeHolder: String
    
    @FocusState private var detailIsFocused: Bool
    
    init(title: String, text: Binding<String>, placeholder: String) {
           UITextView.appearance().backgroundColor = .clear
        self.title = title
        self.text = text
        self.placeHolder = placeholder
        
       }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            if !title.isEmpty {
                Text(title)
                    .font(.custom(Nunito.Medium.rawValue, size: 13))
            }
            
            
            ZStack(alignment: .topLeading) {
                
                if text.wrappedValue.isEmpty {
                    Text(placeHolder)
                        .padding(.all)
                        .foregroundColor(.gray)
                        .font(.custom(Roboto.Regular.rawValue, size: 14))
                }
                
                TextEditor(text: text)
                    .font(.custom(Roboto.Regular.rawValue, size: 14))
                    .padding(15)
                    .focused($detailIsFocused)
                    .opacity(text.wrappedValue.isEmpty ? 0.25 : 1)
                    .foregroundColor(self.text.wrappedValue == placeHolder ? .gray : .primary)
                // this onchange method is use to close the keyboard
                    .onChange(of: text.wrappedValue) { _ in
                        if !text.wrappedValue.filter({ $0.isNewline }).isEmpty {
                            detailIsFocused = false
                        }
                    }
                
                
            }
            .onTapGesture {
                if text.wrappedValue.isEmpty {
                    text.wrappedValue = " "
                }
            }

            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray, lineWidth: 1)
            )
        }
    }
}

struct MLBTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        MLBTextEditor(title: "", text: .constant(""), placeholder: "Name please")
    }
}
