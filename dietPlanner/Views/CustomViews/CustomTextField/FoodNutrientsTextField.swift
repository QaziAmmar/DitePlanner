//
//  FoodNutrientsTextField.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 31/10/2022.
//

import SwiftUI

struct FoodNutrientsTextField: View {

    @FocusState var isFocused: Bool
    var placeHolder = String()
    @Binding var text: String
    var title = String()
    
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(Font.custom(Nunito.Medium.rawValue, size: 20))
                    .foregroundColor(.gray)

                Spacer()
                
                
                HStack(spacing: 10) {
                    TextField(placeHolder, text: $text)
                        .font(.custom(Roboto.Regular.rawValue, size: 14))
                        .padding(15)
                        .focused($isFocused)
                        .cornerRadius(8)
                        .frame(width: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isFocused ? Color(ColorName.appGreen.rawValue) :
                                        .gray.opacity(0.7) , lineWidth: 1)
                        )
                    
                    Text("/g")
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.trailing)
                }
                
               
            }
            CustomDivider()
        }
    }
    

    
}

struct FoodNutrientsTextField_Previews: PreviewProvider {
    static var previews: some View {
        FoodNutrientsTextField(text: .constant("5g"))
    }
}
