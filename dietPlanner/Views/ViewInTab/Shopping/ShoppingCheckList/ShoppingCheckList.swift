//
//  ShoppingCheckList.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 28/10/2022.
//

import SwiftUI

struct ShoppingCheckList: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAddItem = false
    var categoryName: String
    
    @StateObject var vm = ShoppingCheckListViewModel()
    
    
    var body: some View {
        loadView()
            .onAppear{
                // assign the table name according to selected category from back screen.
                vm.categoryName = categoryName
                vm.getshoppingList()
            }
            .sheet(isPresented: $showAddItem) {
                AddShoppingItem(vm: vm)
            }
    }
}

extension ShoppingCheckList {
    
    func loadView() -> some View {
        ZStack(alignment: .bottomTrailing) {
            
            // shows the list of rows

            VStack {
                NavBar(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, title: "Fruits & Vegetables")
                .padding(.vertical)
                
                listView()
                    .padding()
            }
            
            CreateNewBtn {
                showAddItem.toggle()
            }.padding()
        }
    }
    
    
    func listView() -> some View {
        ScrollView {
            
            VStack(spacing: 30) {
                if vm.shopping_items_array.isEmpty {
                    
                    HStack {
                        if vm.noItemFound {
                            Text("No List Found")
                        } else {
                            Text("Loading ... ")
                        }
                        Spacer()
                    }
                }
                ForEach($vm.shopping_items_array) { item in
                    ShoppingCheckListRow(shoppingItem: item, vm: vm)
                }
            }
        }
    }
}


struct ShoppingCheckList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCheckList(categoryName: "")
    }
}
