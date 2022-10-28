//
//  ShoppingRow.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 28/10/2022.
//

import SwiftUI

struct ShoppingRow: View {
    
    var image: String
    var name: String
    var bgColor: Color
    
    var body: some View {
        loadView()
    }
}



extension ShoppingRow {
    func loadView() -> some View {
        HStack {
            Image(image).padding()
            Text(name)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: ImageName.forward.rawValue)
                .foregroundColor(.black)
                .padding(.horizontal)
        }
            .background(bgColor.cornerRadius(10, corners: .allCorners))
    }
}


struct ShoppingRow_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingRow(image: "pie", name: "Bakery", bgColor: Color(ColorName.categorybg1.rawValue))
    }
}
