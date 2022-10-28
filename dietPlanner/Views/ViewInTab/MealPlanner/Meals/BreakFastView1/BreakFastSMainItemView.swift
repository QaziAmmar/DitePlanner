//
//  BreakFastSMainItemView.swift
//  dietPlanner
//
//  Created by Aqsa's on 27/09/2022.
//

import SwiftUI

struct BreakFastSMainItemView: View {
    var data : BFMainModel
    var body: some View {
        HStack{
            Image(data.image)
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            VStack(alignment: .leading){
                Text(data.name)
                    .font(.custom(Nunito.Semibold.rawValue, size: 16))
                .foregroundColor(.black)
                HStack (spacing: 2){
                    Text(String(data.cals))
                        .font(.custom(Nunito.Regular.rawValue, size: 12))
                    .foregroundColor(.gray)
                    Text("cal")
                        .font(.custom(Nunito.Regular.rawValue, size: 12))
                    .foregroundColor(.gray)
                }
                
            }
            Spacer()
        }
    }
}

struct BreakFastSMainItemView_Previews: PreviewProvider {
    static var previews: some View {
        BreakFastSMainItemView(data: BFMainModel( image: "bf", name: "Oranges", cals: 500))
    }
}
