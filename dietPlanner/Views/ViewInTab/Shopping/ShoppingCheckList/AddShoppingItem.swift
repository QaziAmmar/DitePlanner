//
//  AddShoppingItem.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 28/10/2022.
//

import SwiftUI

struct AddShoppingItem: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var vm: ShoppingCheckListViewModel
    @State private var showPicker = false
    
    
    var body: some View {
        loadView()
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
    }
}


// MARK: UIView Extension
extension AddShoppingItem {
    
    func loadView() -> some View {
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, title: "Add Shopping Item")
            
            CustomTextField(placeHolder: "Enter title here", text: $vm.shoppingItemModel.name)

            HStack {
                Text("Category")
                    .font(Font.custom(Nunito.Light.rawValue, size: 18))
                Spacer()
                Text(vm.categoryName)
                    .font(Font.custom(Nunito.Light.rawValue, size: 18))
                    .foregroundColor(Color(ColorName.appGreen.rawValue))
            }
            .padding(.vertical)
            
            Text("You can enter the amount that you want to purchase.")
                .font(Font.custom(Nunito.Light.rawValue, size: 14))
            
            Spacer()
            
            GreenBtn(action: {
                
                vm.addItem { status, message in
                    if status {
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.vm.showError(message: message)
                    }
                }

            }, title: "Save")
   
        }
        .padding()
    }
    
}
struct AddShoppingItem_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingItem(vm: ShoppingCheckListViewModel())
    }
}
