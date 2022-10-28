//
//  AddBreakFastView.swift
//  dietPlanner
//
//  Created by Aqsa's on 22/09/2022.
//

import SwiftUI

struct AddBreakFastView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var viewName: String
    var firebaseId: String
    @StateObject var rvm = DietRecommendationViewModel()
    
    var items : DietRecommendationModel
    var body: some View {
        VStack{
            navBarView()
            Image(items.image)
                .resizable()
                .frame( height: 200)
                .cornerRadius(10)
                .padding([.top],30)
            VStack(alignment: .leading){
                Text(items.name)
                    .font(.custom(Nunito.Bold.rawValue, size: 16 ))
                    .foregroundColor(.black)
                HStack(spacing: 4){
                    Text("by")
                        .font(.custom(Nunito.Regular.rawValue, size: 12 ))
                        .foregroundColor(.gray)
                    Text(items.chef)
                        .font(.custom(Nunito.Regular.rawValue, size: 12 ))
                        .foregroundColor(Color(ColorName.appAqua.rawValue))
                }
                
                Text("Nutrition")
                    .font(.custom(Nunito.Bold.rawValue, size: 16 ))
                    .foregroundColor(.black)
                    .padding([.top],30)
                generateBreakFastItemView()
//                NutritionView(items: BreakFastModel())
                Text("Description")
                    .font(.custom(Nunito.Bold.rawValue, size: 16 ))
                    .foregroundColor(.black)
                    .padding([.top],30)
                Text(items.description)
                    .font(.custom(Nunito.Medium.rawValue, size: 12 ))
                    .foregroundColor(.gray)
                    .padding([.top],15)
                AddButton()
            }
            Spacer()
        }.padding()
    }
}


struct NutritionView: View {
    @StateObject var rvm = DietRecommendationViewModel()
    var items : BreakFastModel
    var body: some View {
        ZStack{
            HStack{
                Image(items.icon)
                .resizable()
                .frame(width: 14, height: 18)
                Text(items.cals)
                    .font(.custom(Nunito.Regular.rawValue, size: 10 ))
                    .foregroundColor(.black)
            }
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(ColorName.nutritionBg.rawValue))
                           .frame(width: 81, height: 38)
                           
        }
    }
}


extension AddBreakFastView {
    func generateBreakFastItemView() -> some View {

        ScrollView(.horizontal,showsIndicators: false){
            HStack {
                ForEach(BreakFastItem) { task in
                        NutritionView(items: task)
                }
            }
            }
    }
    
    func navBarView() -> some View {
        ZStack {
            HStack{
                Button ( action: { self.presentationMode.wrappedValue.dismiss() },
                label: {
             
                    Image(systemName: "arrow.backward").frame(width: 16, height: 16)
                        .foregroundColor(Color(ColorName.appAqua.rawValue))
                       
                })
            
                Spacer()
                
            }
            
            Text(viewName)
                .font(.custom(Nunito.Bold.rawValue, size: 22.5))
                .foregroundColor(Color(ColorName.appAqua.rawValue))
        }
    }
    
    func AddButton() -> some View {
            NavigationLink(
                destination: BreakFastMainView( viewName: viewName, firebaseId: firebaseId)    .navigationBarTitle("")
                    .navigationBarHidden(true)
            , label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .foregroundColor(Color("btnBlue"))
                    HStack(spacing: 5){
                        Text("Add to")
                            .font(.custom("Nunito-Bold", size: 20))
                            .foregroundColor(.white)
                        Text(viewName)
                            .font(.custom("Nunito-Bold", size: 20))
                            .foregroundColor(.white)
                        Text("Meal")
                            .font(.custom("Nunito-Bold", size: 20))
                            .foregroundColor(.white)
                    }
                }.padding([.top], 32)
            })
    }
    
}


struct AddBreakFastView_Previews: PreviewProvider {
    static var previews: some View {
        AddBreakFastView(viewName: "dsd", firebaseId: "df", items: DietRecommendationModel(image: "pancake", name: "Honey Pancake", difficulty: "Easy", time: "30mins", calories: "130kCal", bgClr: "categorybg1", btnBg: "categorybgdark1", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"))
    }
}
