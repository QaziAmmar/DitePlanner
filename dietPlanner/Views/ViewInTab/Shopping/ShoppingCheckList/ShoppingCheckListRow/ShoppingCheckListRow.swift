//
//  ShoppingCheckListRow.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 28/10/2022.
//

import SwiftUI

struct ShoppingCheckListRow: View {
    
    @Binding var shoppingItem: ShoppingItemModel
    @ObservedObject var vm: ShoppingCheckListViewModel
    var isEditing = false
    var categoryName: String
    
    
    var body: some View {
        loadView()
    }
}

// MARK: UIVIew Extension
extension ShoppingCheckListRow {
    
    func loadView() -> some View {
     
        HStack {
            
            HStack {
                Circle().frame(width: 7)
                    .foregroundColor(.black)
                
                Text(shoppingItem.name)
                    .font(Font.custom(Nunito.Regular.rawValue, size: 20))
            }.opacity(shoppingItem.isChecked ? 0.5 : 1)
            
            Spacer()
            
            if isEditing {
                deleteButton()
            } else {
                editButton()
            }
        }
    }
    
    
    func editButton() -> some View {
        Button {
            shoppingItem.isChecked = !shoppingItem.isChecked
            vm.updateShoppingItem(shoppingItem: shoppingItem, categoryName: categoryName)
        } label: {
            Image(shoppingItem.isChecked ? ImageName.check.rawValue : ImageName.unckeck.rawValue)
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
    
    func deleteButton() -> some View {
        Button {
            vm.deleteShppingItem(shoppingItem: shoppingItem, categoryName: categoryName)
        } label: {
            Image(ImageName.delete.rawValue)
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
    
}

struct ShoppingCheckListRow_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCheckListRow(shoppingItem: .constant(ShoppingItemModel()), vm: ShoppingCheckListViewModel(), categoryName: "Bakery")
    }
}
