//
//  TabBarControllerView.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 08/03/2022.
//

import SwiftUI

struct TabBarControllerView: View {
    
    @State private var tabSelection = 0

    init() {

        UITabBar.appearance().unselectedItemTintColor = .gray
    }
    
    var body: some View {
        
        NavigationView {
            TabView(selection: $tabSelection) {
                
                HomeView()
                    .tabItem {
                        VStack {
                            Image(ImageName.meal.rawValue)
                                .renderingMode(.template)
                            Text("Meal Planner")
                        }
                        
                    }
                    .tag(0)
                
                
                ShoppingCategoryListView()
                    .tabItem {
                        
                        VStack {
                            Image(systemName: "cart.fill")
                                .renderingMode(.template)
                            Text("Shopping List")
                        }

                    }
                    .tag(1)
                
                

                RecipeMainView()
                    .tabItem {
                        VStack {
                            Image(ImageName.cook.rawValue)
                                .renderingMode(.template)
                            Text("Recipes")
                        }

                    }
                    .tag(2)
                

                SettingView()
                    .tabItem {
                        VStack {
                            Image(systemName: "ellipsis")
                                .renderingMode(.template)
                            Text("More")
                        }

                    }
                    .tag(3)

            }
            .accentColor(Color(ColorName.appGreen.rawValue))
        }
    }
}

struct TabBarControllerView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarControllerView()
    }
}
