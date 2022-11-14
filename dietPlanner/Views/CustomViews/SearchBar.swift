//
//  SearchBar.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 10/03/2022.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding([.leading])
                
                TextField("Search ...", text: $text)
                    .padding([.trailing,. top, .bottom],7)
                    .foregroundColor(.gray.opacity(0.7))
                    .font(Font.custom(RobotoCondensed.Regular.rawValue, size: 14))
                    .opacity(isEditing ? 1 : 0.7)
                    .onTapGesture {
                        self.isEditing = true
                    }
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.text = ""
                        
                    }) {
                        Text("Cancel")
                            .foregroundColor(.black)
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke()
                    .foregroundColor(.gray.opacity(0.7))
                    .frame(height: 40)
            )
        }
        
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search"))
    }
}
