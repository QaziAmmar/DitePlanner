//
//  DietRecommendationView.swift
//  dietPlanner
//
//  Created by Aqsa's on 21/09/2022.
//

import SwiftUI

struct DietRecommendationView: View {
    var screenName: String
    var data : DietRecommendationModel
    var firebaseId: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(Color(data.bgClr))
                .frame(width: 157 , height: 188)
            VStack{
                Image(data.image)
                    .resizable()
                    .frame(width: 157, height: 87)
                    .cornerRadius(5)
                Text(data.name)
                    .font(.custom(Nunito.Medium.rawValue, size: 11 ))
                    .foregroundColor(.black)
                HStack(spacing: 4){
                    Text(data.difficulty)
                        .font(.custom(Nunito.Regular.rawValue, size: 9 ))
                        .foregroundColor(Color("fontclr"))
                    
                    Rectangle()
                                    .fill(Color("fontclr"))
                                    .frame(width: 2, height: 9)
                    Text(data.time)
                        .font(.custom(Nunito.Regular.rawValue, size: 9 ))
                        .foregroundColor(Color("fontclr"))
                    
                    Rectangle()
                                    .fill(Color("fontclr"))
                                    .frame(width: 2, height: 9)
                    Text(data.calories)
                        .font(.custom(Nunito.Regular.rawValue, size:  9 ))
                        .foregroundColor(Color("fontclr"))
                }
                NavigationLink(
                    destination: AddBreakFastView( viewName: screenName, firebaseId: firebaseId, items: DietRecommendationModel(image: "bun", name: "Honey Pancake", difficulty: "Easy", time: "30mins", calories: "130kCal", bgClr: "categorybg1", btnBg: "categorybgdark1", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"))
                    // use this function form Ammar's Code.
                    // hideNavBar()
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                , label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color(data.btnBg))
                           
                            .frame(width: 86, height: 29)
                        VStack{
                            
                            Text("View")
                                .font(.custom(Nunito.Semibold.rawValue, size: 12 ))
                                .foregroundColor(.white)
                        }
                    }
                })
                
            }.padding([.bottom])
            
        }
    }
}

struct DietRecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        DietRecommendationView(screenName: "kk", data: DietRecommendationModel( image: "bun", name: "Honey Pancake", difficulty: "Easy", time: "30mins", calories: "130kCal", bgClr: "categorybg1", btnBg: "categorybgdark1", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"), firebaseId: "df")
    }
}
