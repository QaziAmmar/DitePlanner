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
    @State private var moveToAddNewRecipe = false




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
                

            // show this button only on My recipe view
            if currentTab == 1 {
                CreateNewBtn {
                    self.moveToAddNewRecipe.toggle()
                }.padding()
            }
        }
    }

    func navBarView() -> some View {
        ZStack{
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

    var hiddenNavigationLinks: some View {

        ZStack() {
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
