//
//  MealRecommendationView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 03/11/2022.
//

import SwiftUI

struct MealRecommendationView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @State private var searchText = ""
    @StateObject var vm = MealRecommendationViewModel()
    
    var title: String
    var date: Date?
    var dayofWeek: String?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        loadView()
            .onAppear {
                vm.fetchMyRecipes()
            }
    }
}

// MARK: UIVIew Extesnion
extension MealRecommendationView {
    
    func loadView() -> some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                NavBar(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, title: title)
                
                ScrollView {
                    VStack (alignment: .leading){
                        SearchBar(text: $searchText)
                            .padding(.top, 5)
                        // MY recipes
                        myRecipes(geometry: geometry)
                            .padding(.vertical)
                        // Recommendation View
                        recommendedRecipes()
                            .padding(.vertical)
                    }
                    
                }.padding(.horizontal)
            }
        }
    }
    
    func myRecipes(geometry: GeometryProxy) -> some View {
        
        
        VStack(alignment: .leading) {
            Text("My Recipes")
                .font(.custom(Nunito.Medium.rawValue, size: 16))
            if vm.myRecipes.isEmpty {
                Text("Loading...")
                    .font(.custom(Nunito.Medium.rawValue, size: 12))
                    .foregroundColor(.gray)
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(vm.myRecipes) { recipe in
                            NavigationLink {
                                HideNavbarOf(view: MealDetailView(vm: vm, recipe: recipe, title: title, date: date, dayofWeek: dayofWeek))
                            } label: {
                                MyRecipeCard(recipe: recipe, geometry: geometry)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func recommendedRecipes() -> some View {
        VStack(alignment: .leading) {
            Text("Recommendation for Diet")
                .font(.custom(Nunito.Medium.rawValue, size: 16))
            LazyVGrid (columns: columns,spacing: 20) {
                //                ForEach($vm.dislike_foods) { dislikeFood in
                VStack {
                    RecommendedMealCard(recipe: .constant(RecipeModel()))
                }
                //                }
            }
        }
    }
    
}




struct MealRecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        MealRecommendationView(title: "Breakfast", date: Date())
    }
}
