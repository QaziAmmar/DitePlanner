//
//  TestView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 28/11/2022.
//


import SwiftUI
import CarBode

struct TestView: View {
    var body: some View {
        GeometryReader { geometry in

            ZStack {
                Image("pancake")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    

                ZStack {
                    Rectangle()
                        .foregroundColor(.black.opacity(0.3))
                        .edgesIgnoringSafeArea(.top)
                        

                    VStack {
                        Spacer()
                        
                        Rectangle()
                            .cornerRadius(20)
                            .frame(width: 300, height: 130)
                            .blendMode(.destinationOut)
                            .overlay {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 24, height: 24)
                            }
                        
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.black.opacity(0.7))
                                .padding()
                                
                            
                            VStack {
                                Image("Logo")
                                    .resizable()
                                    .cornerRadius(10)
                                    .frame(width: 50, height: 50)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.top, 50)
                                    
                                
                                Text("Welcome to")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .bold))
                                Text("Fit Me Food App")
                                    .foregroundColor(.white)
                                    .font(.system(size: 40, weight: .bold))
                                
                                Text("Scan your product")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.top)
                                
                                Spacer()
                            }

                        }.frame(height: geometry.size.height * 0.65)
                        
                        
                    }
                    
                    
                  
                    
                }.compositingGroup()
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
