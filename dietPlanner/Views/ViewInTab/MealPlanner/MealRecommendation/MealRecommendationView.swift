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
    @State private var moveToBarCodeView = false
    
//    These two variablse works togahter
    @State private var moveMealDetailView = false
    @State private var transformedRecipeModel = RecipeModel()
    
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
                vm.fetchOthersRecipes()
            }
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
                    
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
                        SearchBar(text: $searchText, barcodeAction: {
                            // move to barcode scan view
                            moveToBarCodeView.toggle()
                        })
                            .padding(.top, 5)
                        // MY recipes
                        myRecipes(geometry: geometry)
                            .padding(.vertical)
                        // Recommendation View
                        recommendedRecipes()
                            .padding(.vertical)
                    }
                    
                }.padding(.horizontal)
                    .background(hiddenNavigationLinks)
            }
        }
    }
    
    func myRecipes(geometry: GeometryProxy) -> some View {
        
        
        VStack(alignment: .leading) {
            Text("My Recipes")
                .font(.custom(Nunito.Medium.rawValue, size: 16))
            if vm.myRecipes.isEmpty {
                
                if vm.noMyRecipesFound {
                    Text("No Recipe Founded")
                        .font(.custom(Nunito.Medium.rawValue, size: 12))
                        .foregroundColor(.gray)
                } else {
                    Text("Loading...")
                        .font(.custom(Nunito.Medium.rawValue, size: 12))
                        .foregroundColor(.gray)
                }
                    
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
                ForEach(vm.others_Recipes) { recipe in
                    NavigationLink {
                        HideNavbarOf(view: MealDetailView(vm: vm, recipe: recipe, title: title, date: date, dayofWeek: dayofWeek))
                    } label: {
                        RecommendedMealCard(recipe: recipe)
                    }
                }
            }
        }
    }
    
    var hiddenNavigationLinks: some View {
        
        ZStack() {
            NavigationLink("", destination: BarcodeScanView(onProductFound: { productId in
//                1. call the api to get the product detail form Open Source Fodd API
                print("start calling \(productId)")
                vm.callNetworkApi(productId: productId) { recipe in
                    if let recipe = recipe {
                        transformedRecipeModel = recipe
                        moveMealDetailView = true
                    }
                }
                
            }) , isActive: $moveToBarCodeView)
            
            
//            move to product detail for barcode
            NavigationLink("", destination: HideNavbarOf(view: BarcodeMealDetailView(vm: vm, recipe: $transformedRecipeModel, title: title, date: date, dayofWeek: dayofWeek)) , isActive: $moveMealDetailView)
            
            
        }
        .hidden()
        .frame(height: 0)
    }
    
}




struct MealRecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        MealRecommendationView(title: "Breakfast", date: Date())
    }
}
