//
//  MyRecipesView.swift
//  dietPlanner
//
//  Created by Aqsa's on 23/09/2022.
//

import SwiftUI

struct MyRecipesView: View {
    
    @ObservedObject var vm: RecipeViewModel
    var favouriteView: Bool
    @State private var filteredRecipes = [RecipeModel]()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        
    ]
    var body: some View {
        
        ZStack(alignment: .bottomTrailing){
            VStack{
                loadView()
            }
            
        }.onAppear{
            
            filteredRecipes = vm.recipesArray.filter{ recipe in
                return recipe.isLiked
            }
            
        }
    }
}


extension MyRecipesView {
    func loadView() -> some View {
        ScrollView{
            VStack{
                LazyVGrid(columns: columns,spacing: 20) {
                    if favouriteView {
                        if filteredRecipes.isEmpty {
                            Text("No Favourite found")
                        }
                    }
                    if !favouriteView {
                        if vm.recipesArray.isEmpty {
                            Text("No Recipe found")
                        }
                    }
                    ForEach(favouriteView ? $filteredRecipes : $vm.recipesArray) { recipe in
                        RecipeCard(vm: vm, recipe: recipe)
                    }
                }
            }
        }
    }
}


struct MyRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipesView(vm: RecipeViewModel(), favouriteView: true)
    }
}
