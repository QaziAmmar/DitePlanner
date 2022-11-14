//
//  ActiveMealRow.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 31/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ActiveMealRow: View {
    
    var mealList: [RecipeModel]
    @Binding var isLoading: Bool
    
    var title: String
    var body: some View {
        loadView()
    }
}

// MARK: UIView Extension

extension ActiveMealRow {
    
    func loadView() -> some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(Font.custom(Nunito.Medium.rawValue, size: 20))
                .foregroundColor(Color(ColorName.appGreen.rawValue))
            if isLoading {
               
                Text("loading ...")
                    .font(Font.custom(Nunito.Medium.rawValue, size: 12))
                    .padding(.vertical, 5)
            } else {
                if mealList.isEmpty {
                    Text("No \(title) founded")
                        .font(Font.custom(Nunito.Medium.rawValue, size: 12))
                        .padding(.vertical, 5)
                } else {
                    
                    ScrollView {
                        HStack {
                            ForEach(mealList) { meal in
                                mealCell(recipe: meal)
                            }// HStack
                        }// ForEach loop
                    } // ScrollView
                }// if meal.isEmpty
            }
        }
    }
    
    
    func mealCell(recipe: RecipeModel) -> some View {
        VStack {
            WebImage(url: URL(string: recipe.img_url))
                .resizable()
                .placeholder(Image(ImageName.genricPlaceHolder.rawValue))
                .indicator(.activity)
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .padding(10)
                .background(
                    Circle()
                        .frame(width: 65, height: 65)
                        .foregroundColor(randomColorGenerator())
                    
                )
            Text(recipe.name)
                .font(Font.custom(Nunito.Medium.rawValue, size: 12))
                .multilineTextAlignment(.center)
                .frame(height: 40)
        }.frame(width: 80)
    }
}


struct ActiveMealRow_Previews: PreviewProvider {
    static var previews: some View {
        ActiveMealRow(mealList: [], isLoading: .constant(true), title: "Breakfast")
    }
}
