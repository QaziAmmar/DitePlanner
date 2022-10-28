//
//  WalkThrough1View.swift
//  dietPlanner
//
//  Created by Aqsa's on 15/09/2022.
//

import SwiftUI

struct WalkThrough1View: View {
    var body: some View {
        VStack{
            Image("wt1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.top)
            
            VStack(alignment: .leading){
                Text("Track Your Goal")
                    .font(.custom(Nunito.ExtraBold.rawValue, size: 24))
                
                Text("Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals.")
                    .font(.custom(Nunito.Regular.rawValue, size: 14))
                    .foregroundColor(.gray)
                
            }.padding()
            
            Spacer()
            
            
            // Navigation link to move on next screen.
            HStack {
                Spacer()
                NavigationLink {
                    HideNavbarOf(view: WalkThrough2View())
                } label: {
                    Image("wt1btn")
                        .frame(width: 60.0, height: 60.0)
                        .padding()
                }
            }
        }
    }
}

struct WalkThrough1View_Previews: PreviewProvider {
    static var previews: some View {
        WalkThrough1View()
    }
}

