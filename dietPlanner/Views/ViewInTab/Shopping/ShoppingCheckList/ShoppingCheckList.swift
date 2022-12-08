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
    
    @State private var menuSelection = ""
    @State private var sortSelection = "Sort By Date"
    let menuOption = ["Share","Delete"]
    
    @State private var isSharePresented = false
    
    @StateObject var vm = ShoppingCheckListViewModel()
    
    var body: some View {
        loadView()
            .onAppear{
                // assign the table name according to selected category from back screen.
                vm.categoryName = categoryName
                vm.getshoppingList()
            }
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
                
            }
            .sheet(isPresented: $showAddItem) {
                AddShoppingItem(vm: vm)
            }
            .sheet(isPresented: $isSharePresented) {
                
                ActivityViewController(activityItems: vm.shopping_items_array.map { $0.name })
                
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
            Text(categoryName)
                .font(Font.custom(Nunito.Bold.rawValue, size: 22))
                .foregroundColor(Color(ColorName.appGreen.rawValue))
            Spacer()
            
            menuSelectionView()
            
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
                    ShoppingCheckListRow(shoppingItem: item, vm: vm, isEditing: menuSelection == "Delete" ? true : false, categoryName: categoryName)
                }
            }
        }.padding()
    }
    
    
    func menuSelectionView() -> some View {
        
        if menuSelection == "Delete" {
            
            return AnyView(
                Button {
                    menuSelection = ""
                } label: {
                    Text("Done")
                        .padding(.trailing)
                        .foregroundColor(Color(ColorName.appGreen.rawValue))
                })
            
            
        } else {
            
            return  AnyView(
                Menu {
                    // Nested sort menu
                    Menu("Sort"){
                        
                        Button(role: sortSelection == "Sort By Name" ? .destructive : .none, action: {
                            sortSelection = "Sort By Name"
                            vm.shopping_items_array = vm.shopping_items_array.sorted { $0.name < $1.name }
                        }) {
                            Text("Sort By Name")
                           }
                        
                        Button(role: sortSelection == "Sort By Date" ? .destructive : .none, action: {
                            sortSelection = "Sort By Date"
                            vm.shopping_items_array = vm.shopping_items_array.sorted { $0.created_at < $1.created_at }
                        }) {
                            Text("Sort By Date")
                           }
                    }
                    
                    // share and delete button
                    ForEach(menuOption, id: \.self){ item in
                        Button(item) {
                            
                            menuSelection = item
                            
                            if menuSelection == "Share" {
                                if vm.shopping_items_array.isEmpty {
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
    
}


struct ShoppingCheckList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCheckList(categoryName: "")
    }
}
