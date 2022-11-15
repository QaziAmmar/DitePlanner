//
//  SearchBreakFastView.swift
//  dietPlanner
//
//  Created by Aqsa's on 27/09/2022.
//

import SwiftUI

struct SearchBreakFastView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var firebaseId: String
    @State var text = ""
    var body: some View {
        VStack{
            navBarView()
            searchBar()
            HStack(spacing: 35){
                scanBar()
                addBar()
                
            }.padding([.top])
            Spacer()
        }.padding()
        
    }
}


extension SearchBreakFastView {
    
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
            
            Text("Breakfast")
                .font(.custom(Nunito.Bold.rawValue, size: 22.5))
                .foregroundColor(Color(ColorName.appAqua.rawValue))
        }
    }
    
    
    func searchBar() -> some View {
        VStack(alignment: .leading){
           
            
            ZStack(alignment: .trailing){
                Group{
                   
                        TextField("Search", text: $text)
                    
                    
                }
                
                    .padding()
                    .padding([.horizontal],40)
                    .background(
                     Rectangle()
                        
                        .foregroundColor(Color.white)
                                        
                     .opacity(0.2)
                                     
                    )
                    .overlay(
                           RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 0.5)
                       )
                HStack{
                Image(systemName: "magnifyingglass")
                        .accentColor(.gray)
                        .font(.system(size: 24.0))
                        .padding()
             Spacer()
            }
            }
        }.background(.white)
    }
    
    
    func scanBar() -> some View {
            NavigationLink(
                destination: MealCategoryView(planType: "", vm: HomeViewModel())
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
            , label: {
                ZStack() {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .stroke( .white, lineWidth: 0.5)
                        .frame(width: 150, height: 100)
                   
                    
                    VStack {
                    Image( "barscan")
                            .resizable()
                            .frame(width: 44, height: 36)
                        Text("Scan a Barcode")
                            .font(.custom(Nunito.Regular.rawValue, size: 16 ))
                            .foregroundColor(Color(ColorName.appAqua.rawValue))
                    }
                }.background(.white)
            })
    }
    
    
    func addBar() -> some View {
            NavigationLink(
                destination: QuickAddView()    .navigationBarTitle("")
                    .navigationBarHidden(true)
            , label: {
                ZStack() {
                    
                    RoundedRectangle(cornerRadius: 5)
                        .stroke( .white, lineWidth: 0.5)
                        .frame(width: 150, height: 100)
                   
                    
                    VStack {
                    Image( "add")
                            .resizable()
                            .frame(width: 44, height: 36)
                        Text("Quick Add")
                            .font(.custom(Nunito.Regular.rawValue, size: 16 ))
                            .foregroundColor(Color(ColorName.appAqua.rawValue))
                    }
                }.background(.white)
            })
    }
    
    
}

struct SearchBreakFastView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBreakFastView(firebaseId: "df")
    }
}
