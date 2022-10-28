////
////  PopularItemView.swift
////  dietPlanner
////
////  Created by Aqsa's on 21/09/2022.
////
//
//import SwiftUI
//
//struct PopularItemView: View {
//    var values : PopularItemModel
//    var body: some View {
//        VStack{
//            NavigationLink(
//                destination: WeeklyMealPlan()    .navigationBarTitle("")
//                    .navigationBarHidden(true)
//            , label: {
//                ZStack(alignment: .leading) {
//                    
//                    RoundedRectangle(cornerRadius: 5)
//                        .stroke( .gray, lineWidth: 0.5)
//                        .frame( height: 80)
//                   
//                    
//                    HStack {
//                        Image(values.image)
//                            .resizable()
//                            .frame(width: 46, height: 45)
//                        VStack(alignment: .leading, spacing: 3){
//                            Text(values.name)
//                                .font(.custom(Nunito.Medium.rawValue, size: 14 ))
//                                .foregroundColor(.black)
//                            HStack{
//                                Text(values.difficulty)
//                                    .font(.custom(Nunito.Regular.rawValue, size: 12 ))
//                                    .foregroundColor(.gray)
//                                
//                                Rectangle()
//                                                .fill(.gray)
//                                                .frame(width: 2, height: 13)
//                                Text(values.time)
//                                    .font(.custom(Nunito.Regular.rawValue, size: 12 ))
//                                    .foregroundColor(.gray)
//                                
//                                Rectangle()
//                                                .fill(.gray)
//                                                .frame(width: 2, height: 13)
//                                Text(values.difficulty)
//                                    .font(.custom(Nunito.Regular.rawValue, size: 12 ))
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                        
//                        Spacer()
//                    Image(systemName: "chevron.forward")
//                            .foregroundColor(.black)
//                    }.padding()
//                }
//            })
//        }
//            .background(.white)
//    }
//}
//
//
//
//
//struct PopularItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        PopularItemView(values: PopularItemModel())
//    }
//}
