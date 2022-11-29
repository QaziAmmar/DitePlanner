//
//  BarcodeMealDetailView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 29/11/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct BarcodeMealDetailView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var vm: MealRecommendationViewModel
    @Binding var recipe : RecipeModel
    var title: String
    var date: Date?
    var dayofWeek: String?
    
    @State private var recipeMajor = ""
    var recipesTypes = ["Fruits", "Vegetables", "Meats"]
    
    var body: some View {
        loadView()
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
                    
            }
    }
}

extension BarcodeMealDetailView {
    
    func loadView() -> some View {
        GeometryReader { geometry in
            
            VStack(alignment: .leading, spacing: 0) {
                NavBar(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, title: recipe.name)
                ScrollView {
                    ZStack {
                        Color(ColorName.categorybg1.rawValue)
                        WebImage(url: URL(string: recipe.img_url))
                            .resizable()
                            .placeholder(Image(ImageName.genricPlaceHolder.rawValue))
                            .indicator(.activity)
                            .scaledToFit()
                            .opacity(0.9)
                    }.frame(height: geometry.size.height / 3.5)
                    
                    VStack(alignment: .leading) {
                        // Title of Recipe/Meal
                        VStack(alignment: .leading) {
                            
                            Text(recipe.name)
                                .font(Font.custom(Nunito.Medium.rawValue, size: 16))
                            HStack {
                                Text("By")
                                    .font(Font.custom(Nunito.Medium.rawValue, size: 12))
                                
                                Text(recipe.userName)
                                    .font(Font.custom(Nunito.Medium.rawValue, size: 12))
                                    .foregroundColor(Color(ColorName.appGreen.rawValue))
                                
                            }
                            
                        }.padding(.vertical)
                        
                        //  Nutration
                        VStack (alignment: .leading){
                            Text("Nutrition")
                                .font(.custom(Nunito.Medium.rawValue, size: 16))
                            nutrationList()
                        }.padding(.bottom)
                        
                        
                        recipesTypesFields()
                        
                        // Description
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Descriptions")
                                .font(.custom(Nunito.Medium.rawValue, size: 16))
                            
                            Text(recipe.details)
                                .font(.custom(Nunito.Medium.rawValue, size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        
                        Spacer()
                        
                        GreenBtn(action: {
                            
                            if recipe.type.isEmpty {
                                vm.showError(message: "Please select the type of recipe")
                            } else {
                                
                                vm.addBarCodeMeal(recipe: recipe, date: date, dayOfweek: dayofWeek, mealCategory: title) { status, error in
                                    if status {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                                
                            }

                        }, title: "Add to \(title) Meal")
                        .padding(.vertical)
                        
                    }.padding()
                    
                }
            }
        }
    }
    
    
    func nutrationList() -> some View {
        HStack {
            Spacer()
            percentageView(nutration_name: "Calories", nutrationAmount: recipe.calories)
            Spacer()
            percentageView(nutration_name: "Fats", nutrationAmount: recipe.fat)
            Spacer()
            percentageView(nutration_name: "Protenis", nutrationAmount: recipe.protenis)
            Spacer()
            percentageView(nutration_name: "Carbo", nutrationAmount: recipe.carbohydrates)
            Spacer()
        }
    }
    
    func percentageView(nutration_name: String, nutrationAmount: String) -> some View {
        
        HStack {
            ZStack{
                
                Circle()
                    .stroke(.gray, lineWidth: 2)
                    .frame(width: 75, height: 75)
                
                Circle()
                    .rotation(Angle(degrees: 270))
                    .trim(from: 0, to: 1)
                    .stroke(Color(ColorName.appGreen.rawValue), lineWidth: 2)
                    .frame(width: 75, height: 75)
                
                VStack(spacing: 0) {
                    Text(nutrationAmount)
                    
                    HStack {
                        Text(nutration_name)
                            .font(Font.custom(Nunito.Medium.rawValue, size: 8))
                        Image(nutration_name.lowercased())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 10)
                    }
                }
                
            }
            
        }
    }
    
    
    func recipesTypesFields() -> some View {
        VStack {
            
            
            MenuSelection(itemArray: recipesTypes, placeholder: "Recipe Type", selection: $recipeMajor)
            
            if recipeMajor == "Fruits" {
                MenuSelection(itemArray: fruites_name_array, placeholder: "Select Fruits", selection: $recipe.type)
            }
            if recipeMajor == "Vegetables" {
                MenuSelection(itemArray: vegetables_name_array, placeholder: "Select  Vegetables", selection: $recipe.type)
            }
            if recipeMajor == "Meats" {
                MenuSelection(itemArray: meats_name_array, placeholder: "Select  Meats", selection: $recipe.type)
            }
        }
    }
    
    
}
struct BarcodeMealDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeMealDetailView(vm: MealRecommendationViewModel(), recipe: .constant(RecipeModel()), title: "BreakFast", date: Date(), dayofWeek: "Mon")
    }
}
