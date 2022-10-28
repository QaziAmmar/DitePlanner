////
////  BreakFastView1.swift
////  dietPlanner
////
////  Created by Aqsa's on 20/09/2022.
////
//
//import SwiftUI
//
//struct BreakFastView1: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    var ScreenName: String
//    var firebaseId: String
//    @StateObject var vm = CategoryItemViewModel()
//    @StateObject var rvm = DietRecommendationViewModel()
//    @StateObject var revm = RecipeViewModelAbuBakar()
////    @StateObject var pvm = PopularItemViewModel()
//   @State var text = ""
//    let columns = [
//             GridItem(.flexible()),
//             GridItem(.flexible()),
//             
//         ]
//    var body: some View {
//        
//        VStack{
//        navBarView()
//            searchBar().padding([.vertical],30)
//            ScrollView(showsIndicators: false){
//        VStack(alignment: .leading){
//
//       
//       
//            Text("My Recipes")
//                .font(.custom(Nunito.Bold.rawValue, size: 16))
//            RecipeGen()
//            Text("Recommendation for Diet")
//                .font(.custom(Nunito.Bold.rawValue, size: 16))
//            generateRecommendationView()
//        }
//    }
//            
//        }.padding()
//            .background(Color("bgclr"))
//    }
//}
//
//extension BreakFastView1 {
//    
//    func navBarView() -> some View {
//        ZStack {
//            HStack{
//                Button ( action: { self.presentationMode.wrappedValue.dismiss() },
//                label: {
//             
//                    Image(systemName: "arrow.backward").frame(width: 16, height: 16)
//                        .foregroundColor(Color(ColorName.appAqua.rawValue))
//                       
//                })
//            
//                Spacer()
//                
//            }
//            
//            Text(ScreenName)
//                .font(.custom(Nunito.Bold.rawValue, size: 22.5))
//                .foregroundColor(Color(ColorName.appAqua.rawValue))
//        }
//    }
//    
//    func RecipeGen() -> some View {
//        ScrollView(.horizontal,showsIndicators: false){
//            HStack(spacing: 20){
//           
//            ForEach($revm.RecipeItem) { task in
//                RecipeCard(data: task, firebaseId: firebaseId)
//            }
//            
//        }
//    }
//    }
//    
//
//    func generateListView() -> some View {
//        ScrollView(.horizontal,showsIndicators: false){
//            HStack(){
//                ForEach(vm.categoryItem) { task in
//                    CategoryItemView(task: task)
//                }
//            }
//        }
//    }
//    
//    func generateRecommendationView() -> some View {
//        ScrollView(showsIndicators: false){
//            VStack(){
//                LazyVGrid(columns: columns,spacing: 20) {
//                ForEach(rvm.RecommendationItem) { task in
//                    
//                    NavigationLink {
//                        AddBreakFastView(viewName: ScreenName, firebaseId: firebaseId, items: task)
//                    } label: {
//                        DietRecommendationView(screenName: ScreenName, data: task, firebaseId: firebaseId)
//                    }
//                }
//            }
//            }
//        }
//    }
//    
//
//    
//    
//
//
//    func searchBar() -> some View {
//        VStack(alignment: .leading){
//           
//            
//            ZStack(alignment: .trailing){
//                Group{
//                   
//                        TextField("dfdfg", text: $text)
//                    
//                    
//                }
//                
//                    .padding()
//                    .padding([.horizontal],40)
//                    .background(
//                     Rectangle()
//                        
//                        .foregroundColor(Color.white)
//                                        
//                     .opacity(0.2)
//                                     
//                    )
//                    .overlay(
//                           RoundedRectangle(cornerRadius: 5)
//                            .stroke(Color.gray, lineWidth: 0.5)
//                       )
//                HStack{
//                Image(systemName: "magnifyingglass")
//                        .accentColor(.gray)
//                        .font(.system(size: 24.0))
//                        .padding()
//                Spacer()
//                    NavigationLink(
//                        destination: SearchBreakFastView(firebaseId: firebaseId)    .navigationBarTitle("")
//                            .navigationBarHidden(true)
//                    ,
//                label: {
//                    Image(systemName:  "barcode.viewfinder")
//                        .accentColor(.black)
//                        .font(.system(size: 24.0))
//                        .padding()
//                })
//            }
//            }
//        }.background(.white)
//    }
//    
//    func DailyScheduleBtn() -> some View {
//            NavigationLink(
//                destination: WeeklyMealPlan(firebaseId: firebaseId)    .navigationBarTitle("")
//                    .navigationBarHidden(true)
//            , label: {
//                ZStack(alignment: .leading) {
//                    
//                    RoundedRectangle(cornerRadius: 5)
//                        .stroke( .gray, lineWidth: 0.5)
//                      .frame(height: 56)
//                   
//                    
//                    HStack {
//                        Text("Daily Schedule")
//                            .foregroundColor( .gray)
//                            .font(.custom(Nunito.Semibold.rawValue, size: 20 ))
//                        
//                    Spacer()
//                    Image(systemName: "chevron.forward")
//                    }.padding()
//                }.background(.white)
//            })
//    }
//}
//
//struct BreakFastView1_Previews: PreviewProvider {
//    static var previews: some View {
//        BreakFastView1(ScreenName: "dff", firebaseId: "dfs")
//    }
//}
