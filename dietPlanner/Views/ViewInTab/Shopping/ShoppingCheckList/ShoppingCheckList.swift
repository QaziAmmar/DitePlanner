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
    @State private var isEditing = false
    
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
                
                navBar()
                    .padding(.top)

                listView()
                    
            }
            
            CreateNewBtn {
                showAddItem.toggle()
            }.padding()
        }
    }
    
    func navBar() -> some View {
        HStack {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                
                Image("back")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color(ColorName.appGreen.rawValue))
            }
            .frame(width: 50, height: 50)
            Spacer()
            Text("Fruits & Vegetables")
                .font(Font.custom(Nunito.Bold.rawValue, size: 22))
                .foregroundColor(Color(ColorName.appGreen.rawValue))
            Spacer()
            
            Button {
                isEditing = !isEditing
            } label: {
                if isEditing {
                    Text("Done")
                        .padding(.trailing)
                } else {
                    Image(systemName: "ellipsis")
                        .frame(width: 50, height: 50)
                        .rotationEffect(.degrees(-90))
                }
            }
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
                    ShoppingCheckListRow(shoppingItem: item, vm: vm, isEditing: isEditing)
                }
            }
        }.padding()
    }
}


struct ShoppingCheckList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCheckList(categoryName: "")
    }
}
