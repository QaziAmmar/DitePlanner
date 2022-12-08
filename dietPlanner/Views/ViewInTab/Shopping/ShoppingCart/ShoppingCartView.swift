//
//  ShoppingCartView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 07/12/2022.
//

import SwiftUI

struct ShoppingCartView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showAddItem = false
    @State private var isEditing = false
    
    @State private var menuSelection = ""
    @State private var sortSelection = "Sort By Date"
    let menuOption = ["Share","Delete"]
    
    @State private var isSharePresented = false
    
    @StateObject var vm = ShoppingCheckListViewModel()
    
    var body: some View {
        loadView()
            .onAppear{
                // assign the table name according to selected category from back screen.
                vm.getAllshoppingList()
            }
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
                
            }
            .sheet(isPresented: $isSharePresented) {
                ActivityViewController(activityItems: vm.getAllShoppingItemListName())
            }
    }
}

extension ShoppingCartView {
    
    func loadView() -> some View {
        
        VStack {
            
            navBar()
                .padding(.top)
            
            listView()
            
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
            Text("Shopping List")
                .font(Font.custom(Nunito.Bold.rawValue, size: 22))
                .foregroundColor(Color(ColorName.appGreen.rawValue))
            Spacer()
            
            menuSelectionView()
            
        }
    }
    
    func listView() -> some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 30) {
                
                ForEach(vm.categoriesName, id: \.self) { category in
                    VStack(alignment: .leading) {
                        
                        var items = vm.all_shopping_items[category] ?? []
                        
                        if items.count != 0 {
                        
                            HStack {
                                Text(category)
                                    .font(Font.custom(Nunito.Medium.rawValue, size: 25))
                                    .foregroundColor(Color(ColorName.appGreen.rawValue))
                                Spacer()
                            }
                            
                            ForEach(items, id: \.id) { item in
                                let itemBinding = Binding<ShoppingItemModel>(
                                    get: {item},
                                    set: {
                                        if let items = vm.all_shopping_items[category],
                                           let i = items.firstIndex(where: {$0.id == item.id}) {
                                            vm.all_shopping_items[category]?[i] = $0
                                        }
                                    }
                                )
                                ShoppingCheckListRow(shoppingItem: itemBinding, vm: vm, isEditing: menuSelection == "Delete" ? true : false, categoryName: category )
                                
                            }
                        }
                    }
                    
                }
                
            }
        }.padding()
    }
    
    
    func menuSelectionView() -> some View {
        
        return  AnyView(
            Menu {
//                // Nested sort menu
//                Menu("Sort"){
//                    
//                    Button(role: sortSelection == "Sort By Name" ? .destructive : .none, action: {
//                        sortSelection = "Sort By Name"
//                        vm.shopping_items_array = vm.shopping_items_array.sorted { $0.name < $1.name }
//                    }) {
//                        Text("Sort By Name")
//                    }
//                    
//                    Button(role: sortSelection == "Sort By Date" ? .destructive : .none, action: {
//                        sortSelection = "Sort By Date"
//                        vm.shopping_items_array = vm.shopping_items_array.sorted { $0.created_at < $1.created_at }
//                    }) {
//                        Text("Sort By Date")
//                    }
//                }
                
                // share and delete button
                ForEach(menuOption, id: \.self){ item in
                    Button(item) {
                        
                        menuSelection = item
                        
                        if menuSelection == "Share" {
                            if vm.getAllShoppingItemListName().isEmpty {
                                vm.showError(message: "No shopping item")
                                menuSelection = ""
                            } else {
                                // make a proper list before sharing it to the ActivityView
                                isSharePresented.toggle()
                            }
                        }
                    }
                }
                
            } label: {
                Image(systemName: "ellipsis")
                    .frame(width: 50, height: 50)
                    .rotationEffect(.degrees(-90))
                    .foregroundColor(Color(ColorName.appGreen.rawValue))
            })
        
        
    }
    
}


struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}
