//
//  ShoppingListView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 28/10/2022.
//

import SwiftUI

struct ShoppingCategoryListView: View {
    
    @State var menuOpen : Bool = false
    
    //    Navigation Variables
    @State private var moveToPreferences = false
    @State private var moveToEditProfile = false
    @State private var moveToChangePassword = false
    @State private var moveToGoals = false
    
    // localVariable
    var categoriesName = ["Bakery","Fruits & Vagetables", "Meat & poultry", "Dairy & Eggs", "Pantry", "Household"]
    var categoiresIcon = ["pie", "fruits", "meats", "cow", "pantry", "household"]
    
    var body: some View {
        loadView()
    }
}



// MARK: UIVIew Extension
extension ShoppingCategoryListView {
    
    func loadView() -> some View {
        VStack{
            shoppingList()
            
        }.padding()
        
    }
    
    
    
    
    func shoppingList() -> some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("Select Category")
                    .font(Font.custom(Nunito.Medium.rawValue, size: 30))
                
                Spacer()
                
                NavigationLink(destination: HideNavbarOf(view: ShoppingCartView()), label: {
                    Image("checkList")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                })
            }
            
            
            ScrollView {
                VStack {
                    ForEach(0..<categoriesName.count, id: \.self) { i in
                        // generate different colors
                        let color: Color = ((i % 2 == 0) ? Color(ColorName.categorybg1.rawValue) : Color(ColorName.categorybg2.rawValue))
                        NavigationLink(destination: HideNavbarOf(view: ShoppingCheckList(categoryName: categoriesName[i])))
                        {
                            ShoppingRow(image: categoiresIcon[i], name: categoriesName[i], bgColor: color)
                        }
                    }
                }
            }
        }
    }
}




struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCategoryListView()
    }
}
