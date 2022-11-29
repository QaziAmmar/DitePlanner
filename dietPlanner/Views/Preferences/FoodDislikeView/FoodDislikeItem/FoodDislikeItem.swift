//
//  FoodDislikeItem.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 27/10/2022.
//

import SwiftUI

struct FoodDislikeItem: View {
    
    @Binding var dislikeFood: DislikeFoodModel
    @ObservedObject var vm: PreferenceViewModel
    
    var body: some View {
        loadView()
    }
}


extension FoodDislikeItem {
    func loadView() -> some View {
        
        VStack{
            
            Button {
                dislikeFood.isSelected = !dislikeFood.isSelected
                vm.updateDislikeFood(dislikeFood: dislikeFood)
            } label: {
                ZStack() {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .stroke( dislikeFood.isSelected ? Color(ColorName.appAqua.rawValue) : .gray, lineWidth: 1)
                        .frame(width: 150 ,height: 50)
                        .background(.white)
                    
                    HStack(alignment: .center) {
                        
//                        Image(dislikeFood.image)
                        Text(dislikeFood.name)
                            .foregroundColor(dislikeFood.isSelected ? Color(ColorName.appAqua.rawValue) : .black)
                            .font(.custom("Nunito-Light", size: 16))
                    }
                }
            }
        }
    }
}


struct FoodDislikeItem_Previews: PreviewProvider {
    static var previews: some View {
        FoodDislikeItem(dislikeFood: .constant(DislikeFoodModel(name: "Peanuts", isSelected: false)), vm: PreferenceViewModel())
    }
}
