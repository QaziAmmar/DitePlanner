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
        UITabBar.appearance().backgroundColor = UIColor(named: ColorName.appMainLight.rawValue)
        UITabBar.appearance().unselectedItemTintColor = .gray
    }
    
    var body: some View {
        TabView(selection: $tabSelection) {
            
            TabViewsContainer(view: MealPlannerView())
                .tabItem {
                    VStack {
                        Image(ImageName.meal.rawValue)
                            .renderingMode(.template)
                        Text("Meal Planner")
                    }
                    
                }
                .tag(0)
            
            TabViewsContainer(view: ShoppingCategoryListView())
            
                .tabItem {
                    
                    VStack {
                        Image(ImageName.cart.rawValue)
                            .renderingMode(.template)
                        Text("Shopping List")
                    }

                }
                .tag(1)
            
            
            TabViewsContainer(view: RecipeMainView())
                .tabItem {
                    VStack {
                        Image(ImageName.cook.rawValue)
                            .renderingMode(.template)
                        Text("Recipes")
                    }

                }
                .tag(2)

        }
        .accentColor(Color(ColorName.appGreen.rawValue))
    }
}

struct TabBarControllerView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarControllerView()
    }
}
