//
//  MenuSelection.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 04/11/2022.
//

import SwiftUI

struct MenuSelection: View {

    var itemArray = [String]()
    var placeholder: String
    @Binding var selection: String
    
    
    
    
    var body: some View {
        Menu {
            ForEach(itemArray, id: \.self){ item in
                Button(item) {
                    selection = item
                }
            }
        } label: {
            HStack {
                Text(selection.isEmpty ? placeholder : selection)
                    .font(.custom(Roboto.Regular.rawValue, size: 14))
                    .padding(20)
                    .foregroundColor(selection.isEmpty ? .gray : .black)
                
                Spacer()
                
                Image(ImageName.dropDown.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12)
                    .padding()
                
            }.overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.gray.opacity(0.7)))
        }
    }
}

struct MenuSelection_Previews: PreviewProvider {
    static var previews: some View {
        MenuSelection( placeholder: "Easy", selection: .constant("hello"))
    }
}
