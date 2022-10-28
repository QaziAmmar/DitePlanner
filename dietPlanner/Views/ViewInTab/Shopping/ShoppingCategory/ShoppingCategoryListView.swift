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
            .background(
                hiddenNavigationLinks
            )
    }
}



// MARK: UIVIew Extension
extension ShoppingCategoryListView {
    
    func loadView() -> some View {
        ZStack(){
            VStack{
                
                navBarView()
                shoppingList()
                
            }.padding()
                .background(Color("bgclr"))
            
            // sidemenu view
            ZStack {
                SideMenu(width: 300,
                         isOpen: self.menuOpen,
                         menuClose: self.openMenu,
                         onClick: { selectedView in
                    self.performNavigation(at: selectedView)
                })
            }
        }
    }
    
    
    
    func navBarView() -> some View {
        ZStack{
            HStack{
                
                if !self.menuOpen {
                    Button(action: {
                        self.openMenu()
                    },
                           label: {
                        
                        Image("Drawer")
                            .resizable()
                            .frame(width: 24.0, height: 24.0)
                    })
                    
                }
                Spacer()
                
            }
            Text("Shopping List")
                .font(.custom(Nunito.Bold.rawValue, size: 22.5))
                .foregroundColor(Color(ColorName.appAqua.rawValue))
        }
    }
    
    
    func shoppingList() -> some View {
        VStack(alignment: .leading) {
            
            Text("Select Category")
                .font(Font.custom(Nunito.Medium.rawValue, size: 30))
            
            ScrollView {
                VStack {
                    ForEach(0..<categoriesName.count, id: \.self) { i in
                        // generate different colors
                        let color: Color = ((i % 2 == 0) ? Color(ColorName.categorybg1.rawValue) : Color(ColorName.categorybg2.rawValue))
                        NavigationLink(
                            destination: HideNavbarOf(view: ShoppingCheckList(categoryName: categoriesName[i])))
                        {
                            ShoppingRow(image: categoiresIcon[i], name: categoriesName[i], bgColor: color)
                        }
                    }
                }
            }
        }
    }
}



// MARK: Custom Function extension
extension ShoppingCategoryListView {
    
    // function to open/close menu
    func openMenu() {
        self.menuOpen.toggle()
    }
    
    func performNavigation(at view: NavViews) {
        self.menuOpen.toggle()
        switch view {
        case .preferences:
            moveToPreferences = true
        case .edit_profile:
            moveToEditProfile = true
        case .change_password:
            moveToChangePassword = true
        case .logout:
            UserDefaultManager.shared.logout()
        case .goals:
            moveToGoals = true
        }
    }
    
    var hiddenNavigationLinks: some View {
        
        ZStack() {
            NavigationLink("", destination: HideNavbarOf(view: ChangePreferenceView()) , isActive: $moveToPreferences)
            NavigationLink("", destination: HideNavbarOf(view: EditProfileView()), isActive: $moveToEditProfile)
            NavigationLink("", destination: HideNavbarOf(view: ChangePasswordView()), isActive: $moveToChangePassword)
            NavigationLink("", destination: HideNavbarOf(view: CalorieGoalView()), isActive: $moveToGoals)
        }
        .hidden()
        .frame(height: 0)
    }
}


struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCategoryListView()
    }
}
