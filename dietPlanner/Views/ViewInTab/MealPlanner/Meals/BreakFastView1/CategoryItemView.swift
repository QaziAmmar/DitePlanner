//
//  CategoryItemView.swift
//  dietPlanner
//
//  Created by Aqsa's on 20/09/2022.
//

import SwiftUI

struct CategoryItemView: View {
    var task : CategoryItemModel
    var body: some View {
        
            
            Button {
                print("tapped")
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(Color(task.bgClr))
                       
                                    .frame(width: 80, height: 100)
                    VStack{
                        Image(task.image)
                        .resizable()
                        .frame(width: 40, height: 40)
                        Text(task.name)
                            .font(.custom(Nunito.Regular.rawValue, size: 12 ))
                            .foregroundColor(.black)
                    }
                }
            }

       
        
    
    }
}

struct CategoryItemView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItemView(task: CategoryItemModel())
    }
}
