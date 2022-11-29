//
//  RecommendedMealCard.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 03/11/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecommendedMealCard: View {
    
    var recipe : RecipeModel
    
    var body: some View {
        loadView()
    }
}

// MARK: UIView Extension
extension RecommendedMealCard {
    func loadView() -> some View {
        VStack(){
            
            VStack(spacing: 0){
                
                WebImage(url: URL(string: recipe.img_url))
                    .resizable()
                    .placeholder(Image(ImageName.genricPlaceHolder.rawValue))
                    .indicator(.activity)
                    .scaledToFill()
                    .frame(width: 150, height: 90)
                    .cornerRadius(6, corners: [.topLeft, .topRight])
                
                VStack(spacing: 3) {
                    HStack(){
                        Text(recipe.name)
                            .font(.custom(Nunito.Medium.rawValue, size: 12))
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                    }.padding(.top, 5)
                    
                    Text("\(recipe.make_difficulity) | \(recipe.makeTime)")
                        .font(.custom(Nunito.Medium.rawValue, size: 10))
                        .foregroundColor(.gray)
                    
                    Text("| 180kCal")
                        .font(.custom(Nunito.Medium.rawValue, size: 10))
                        .foregroundColor(.gray)
                    
                    
                    Text("View")
                        .font(.custom(Nunito.Medium.rawValue, size: 12))
                        .foregroundColor(.white)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 30)
                        .background(
                        LinearGradient(gradient: Gradient(colors: [Color(hex: "9DCEFF"), Color(hex: "92A3FD")]), startPoint: .leading, endPoint: .trailing)
                            .cornerRadius(20)
                        
                    )
                    .padding(.vertical, 10)   
                }
                .frame(width: 150)
                .background(
                    Rectangle()
                        .foregroundColor(Color(ColorName.categorybg1.rawValue))
                        .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
                )
            }
        }
    }
}

struct RecommendedMealCard_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedMealCard( recipe: RecipeModel())
    }
}
