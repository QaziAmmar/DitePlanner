//
//  WalkThrough2View.swift
//  dietPlanner
//
//  Created by Aqsa's on 15/09/2022.
//

import SwiftUI

struct WalkThrough2View: View {
    
    // declaring variables
    
    var body: some View {
        loadView()
            .onAppear {
                // notify user defauls that walk through screens has been visited
                UserDefaultManager.shared.updateWalkThroughStatus(isSeen: true)
                
            }
    }
}


// MAKR: View Extension
extension WalkThrough2View {
    
    
    func loadView() -> some View {
        VStack{
            Image(ImageName.wt2.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.top)
            
            VStack(alignment: .leading){
                
                Text("Track Your Goal")
                    .font(.custom("Nunito-ExtraBold", size: 24))
                Text("Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals.")
                    .font(.custom("Nunito-Regular", size: 14))
                    .foregroundColor(.gray)
   
            }.padding()
            
            Spacer()
            
            HStack {
                Spacer()

                NavigationLink {
                    HideNavbarOf(view: ContentView())
                } label: {
                    Image("wt2btn")
                        .frame(width: 60.0, height: 60.0)
                        .padding()
                }
            }
        }
        
    }
}

struct WalkThrough2View_Previews: PreviewProvider {
    static var previews: some View {
        WalkThrough2View()
    }
}
