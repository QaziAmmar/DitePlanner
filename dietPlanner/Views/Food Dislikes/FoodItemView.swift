//
//  FoodItemView.swift
//  dietPlanner
//
//  Created by Aqsa's on 19/09/2022.
//

import SwiftUI

struct FoodItemView: View {
    @State private var isChecked = false
    @Binding var selectedFoodItems: [String]
    var text : String
    var icons : String
    var body: some View {
        
        VStack{
            food()
        }
    }
}

struct FoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemView(selectedFoodItems: .constant(["df"]), text: "Peanut",icons: FoodIcons.peanuts.rawValue)
    }
}

extension FoodItemView {
    func food() -> some View {
        Button {
                isChecked.toggle()
            
            if isChecked {
                selectedFoodItems.append(text)
            } else {
                
                let index = selectedFoodItems.firstIndex(of: text)
                selectedFoodItems.remove(at: index!)
            }
            
            print(selectedFoodItems)
            
        } label: {
            ZStack() {
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke( isChecked ? Color(ColorName.appAqua.rawValue) : .gray, lineWidth: 1)
                    .frame(width: 150 ,height: 50)
                  .background(.white)
                
                HStack(alignment: .center) {
                 
                    Image(icons)
                    Text(text)
                        .foregroundColor(isChecked ? Color(ColorName.appAqua.rawValue) : .black)
                        .font(.custom("Nunito-Light", size: 16))
                       
                }
                
                
            }
           
        }
    }
}
