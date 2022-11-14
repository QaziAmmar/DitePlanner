//
//  RecipeCard.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 25/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeCard: View {
    
    @ObservedObject var vm: RecipeViewModel
    @Binding var recipe : RecipeModel

    var body: some View {
        
        ZStack(alignment: .topLeading){
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .fill(Color(ColorName.recipeCardBg.rawValue))
                    .frame(width: 150, height: 193)
            VStack(spacing: 0){
                
                WebImage(url: URL(string: recipe.img_url))
                        .resizable()
                        .placeholder(Image(ImageName.genricPlaceHolder.rawValue))
                        .indicator(.activity)
                        .scaledToFill()
                        .frame(width: 150, height: 140)
                        .cornerRadius(6, corners: [.topLeft, .topRight])
                        
                
                    HStack(){
                        Text(recipe.name)
                        .font(.custom(Nunito.Medium.rawValue, size: 12))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                   Spacer()
                        
                        Button {
                            // update the model accordingly
                            recipe.isLiked.toggle()
                            recipe.updated_at = Date().timeIntervalSince1970
                            
//                            vm.likeRecipe(recipe: recipe)

                        } label: {
                            Image(recipe.isLiked == true ? Heart.heartFill.rawValue : Heart.heart.rawValue)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding([.leading, .top, .bottom])
                        }

                    }.padding([.horizontal])
                    .frame(width: 150, height: 63)
                }
        }
    }
}


struct DiscoverRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard(vm: RecipeViewModel(), recipe: .constant(RecipeModel()))
    }
}
