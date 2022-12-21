//
//  MealPlannerItemRow.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 31/10/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MealPlannerItemRow: View {
    
    @State private var item = RowItem(offset: 0, isSwiped: false)
    var recipe: RecipeModel
    var onDelete: (RecipeModel) -> ()
    @State private var opacity = 0.0
    
    var body: some View {
        loadView()
    }
}

// MARK: UIView Extension
extension MealPlannerItemRow {
    
    func loadView() -> some View {
        ZStack {
            
            LinearGradient(gradient: .init(colors: [Color.red.opacity(0.7), Color.red]), startPoint: .leading, endPoint: .trailing)
            HStack {
                Spacer()
                
                Button(action: {
                    withAnimation(.easeIn){deleteItem()}
                }) {
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 90, height: 50)
                }
            }
            
            HStack {
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
                                .foregroundColor(randomColorGenerator(str: recipe.id ?? "0"))
                            
                        )

                VStack (alignment: .leading, spacing: 5){
                    Text(recipe.name)
                        .font(Font.custom(Nunito.Regular.rawValue, size: 16))
                    Text(String(recipe.totalCalories))
                        .font(Font.custom(Nunito.Regular.rawValue, size: 12))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .background(Color.white)
            .offset(x: item.offset)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
            
        }
       
    }

}

// MAKR: Swipe to delete
extension MealPlannerItemRow {
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < 0 {
            if item.isSwiped {
                item.offset = value.translation.width - 90
            } else {
                item.offset = value.translation.width
            }
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            if value.translation.width < 0 {
                if -value.translation.width > UIScreen.main.bounds.width / 2 {
                    item.offset = -1000
                    deleteItem()
                } else if -item.offset > 50 {
                    item.isSwiped = true
                    item.offset = -90
                } else {
                    item.isSwiped = false
                    item.offset = 0
                }
            } else {
                item.isSwiped = false
                item.offset = 0
            }
        }
    }
    
    // Removing Item
    func deleteItem() {
        onDelete(recipe)
    }
    
}


struct MealPlannerItemRow_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerItemRow(recipe: RecipeModel(), onDelete: { recipe in
            print(recipe.id)
        })
    }
}


struct RowItem {
    var offset: CGFloat
    var isSwiped: Bool
}
