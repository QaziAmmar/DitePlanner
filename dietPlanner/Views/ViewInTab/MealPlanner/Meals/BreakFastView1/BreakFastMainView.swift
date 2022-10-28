//
//  BreakFastMainView.swift
//  dietPlanner
//
//  Created by Aqsa's on 27/09/2022.
//

import SwiftUI

struct BreakFastMainView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var viewName: String
    var firebaseId: String
    @StateObject var bvm = BFMainModelView()
    var body: some View {
       
        VStack(alignment: .leading){
            
            ZStack(alignment: .bottomTrailing){
                VStack{
            MyCalendarY(onDatePicked: { date in
                print(date)
            }).frame( height: 80)
                .background(Color("bgclr"))
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
            Text("Breakfast")
                .font(.custom(Nunito.Bold.rawValue, size: 20))
            .foregroundColor(.black)
       
            generateListView()
                    Text("Today's Breakfast Nutritions")
                        .font(.custom(Nunito.Bold.rawValue, size: 20))
                    .foregroundColor(.black)
            
           calBar()
                proteinsBar()
                fatsBar()
                carbBar()
        }
        }
            }
//                addButton()
        }
            
        }.padding()
            .background(Color("bgclr"))
    }
}


extension BreakFastMainView {
    
//    func addButton() -> some View {
//        NavigationLink(
//            destination: BreakFastView1(ScreenName: viewName, firebaseId: firebaseId)
//            // use this function form Ammar's Code.
//            // hideNavBar()
//                .navigationBarTitle("")
//                .navigationBarHidden(true)
//       , label: {
//            ZStack{
//                
//            RoundedRectangle(cornerRadius: 30, style: .continuous)
//                .fill(Color("purple"))
//                            .frame(width: 60, height: 60)
//                Text("+")
//                    .font(.custom(Nunito.Bold.rawValue, size: 20))
//                    .foregroundColor(.white)
//            }
//        })
//    }
    
    func calculateCalories() -> Int {
            var sum = 0
            for key in MainItem {
                sum = sum + key.cals
            }
        return sum
    }
    
    func calBar () -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 0.5)
              .frame(height: 63)
              .background(.white)
            
        VStack{
            HStack {
                HStack{
                    Text("Calories")
                        .font(.custom(Nunito.Semibold.rawValue, size: 12))
                    .foregroundColor(.black)
                    Image("cals")
                        .resizable()
                        .frame(width: 15, height: 18)
                }
                Spacer()
                Text("870 cal")
                    .font(.custom(Nunito.Regular.rawValue, size: 12))
                .foregroundColor(.gray)
            }
        ProgressBar(currentProgress: 0.5)
        }.padding()
        }
    }
    
    func proteinsBar () -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 0.5)
              .frame(height: 63)
              .background(.white)
            
        VStack{
            HStack {
                HStack{
                    Text("Proteins")
                        .font(.custom(Nunito.Semibold.rawValue, size: 12))
                    .foregroundColor(.black)
                    Image("proteins")
                        .resizable()
                        .frame(width: 16, height: 15)
                }
                Spacer()
                Text("870 cal")
                    .font(.custom(Nunito.Regular.rawValue, size: 12))
                .foregroundColor(.gray)
            }
        ProgressBar(currentProgress: 0.8)
        }.padding()
        }
    }
    
    func fatsBar () -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 0.5)
              .frame(height: 63)
              .background(.white)
            
        VStack{
            HStack {
                HStack{
                    Text("Fats")
                        .font(.custom(Nunito.Semibold.rawValue, size: 12))
                    .foregroundColor(.black)
                    Image("fats")
                        .resizable()
                        .frame(width: 18, height: 16)
                }
                Spacer()
                Text("870 cal")
                    .font(.custom(Nunito.Regular.rawValue, size: 12))
                .foregroundColor(.gray)
            }
        ProgressBar(currentProgress: 0.8)
        }.padding()
        }
    }
    
    
    func carbBar () -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 0.5)
              .frame(height: 63)
              .background(.white)
            
        VStack{
            HStack {
                HStack{
                    Text("Carbs")
                        .font(.custom(Nunito.Semibold.rawValue, size: 12))
                    .foregroundColor(.black)
                    Image("carbs")
                        .resizable()
                        .frame(width: 15, height: 18)
                }
                Spacer()
                Text("870 cal")
                    .font(.custom(Nunito.Regular.rawValue, size: 12))
                .foregroundColor(.gray)
            }
        ProgressBar(currentProgress: 0.8)
        }.padding()
        }
    }
    
    

    
    
    func generateListView() -> some View {
        
        VStack{
                ForEach(MainItem) { task in
                    BreakFastSMainItemView(data: task)
                }
            
        }
    }
}


struct BreakFastMainView_Previews: PreviewProvider {
    static var previews: some View {
        BreakFastMainView( viewName: "df", firebaseId: "dsfs")
    }
}
