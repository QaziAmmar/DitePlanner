//
//  MyRecipeCard.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 03/11/2022.
//



import SwiftUI
import SDWebImageSwiftUI

struct MyRecipeCard: View {
    
    var recipe : RecipeModel
    var geometry: GeometryProxy
    // make geometry object
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            
            WebImage(url: URL(string: recipe.img_url))
                .resizable()
                .placeholder(Image(ImageName.genricPlaceHolder.rawValue))
                .indicator(.activity)
                .scaledToFill()
                .frame(width: geometry.size.width / 3.2, height: 100)
                .clipped()
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.custom(Nunito.Medium.rawValue, size: 11))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding([.leading, .top], 1)
                Spacer()
            }.frame(width: geometry.size.width / 3.2, height: 40)
          
            
        }.cornerRadius(6)
            .background {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(ColorName.recipeCardBg.rawValue))
            }
    }
}


struct MyRecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
            MyRecipeCard(recipe: RecipeModel(), geometry: geometry)
        }
    }
}
