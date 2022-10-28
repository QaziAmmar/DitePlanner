//
//  RecipeMainView.swift
//  dietPlanner
//
//  Created by Aqsa's on 23/09/2022.
//

import SwiftUI

struct RecipeMainView: View {

    @State var menuOpen : Bool = false
    @State var currentTab: Int = 0
    
    @StateObject var vm = RecipeViewModel()

    //    Navigation Variables
    @State private var moveToPreferences = false
    @State private var moveToEditProfile = false
    @State private var moveToChangePassword = false
    @State private var moveToGoals = false
    @State private var moveToAddNewRecipe = false

    // Present View Variables



    var body: some View {
        loadView()
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
            .onAppear {
                vm.getRecipeList()
            }
            .background(
                hiddenNavigationLinks
            )

    }
}

// MARK: UIVIew extesnion
extension RecipeMainView {

    func loadView() -> some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
                navBarView()
                // selector.
                HorizontalTabSelection(categores: ["Favourite", "My Recipes"], selectedIndex: $currentTab)
                viewsInTabbar()


                Spacer()

            }.padding()
                .background(Color("bgclr"))

            // show this button only on My recipe view
            if currentTab == 1 {
                CreateNewBtn {
                    self.moveToAddNewRecipe.toggle()
                }.padding()
            }


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
            Text("Meal Planner")
                .font(.custom(Nunito.Bold.rawValue, size: 22.5))
                .foregroundColor(Color(ColorName.appAqua.rawValue))
        }
    }

    func viewsInTabbar() -> some View {
        TabView(selection: self.$currentTab) {
            MyRecipesView(vm: vm, favouriteView: true).tag(0)
            MyRecipesView(vm: vm, favouriteView: false).tag(1)

        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }




}


// MARK: Custom Function extension
extension RecipeMainView {

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
            NavigationLink("", destination: HideNavbarOf(view: AddRecipeView(vm: vm)), isActive: $moveToAddNewRecipe)
                    }
                    .hidden()
                    .frame(height: 0)
        }
}


struct RecipeMainView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RecipeMainView()
        }
    }
}
