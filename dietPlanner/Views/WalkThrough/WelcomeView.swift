//
//  ContentView.swift
//  dietPlanner
//
//  Created by Aqsa's on 15/09/2022.
//

import SwiftUI

// make seprate extesion for load view.

struct WelcomeView: View {
    @EnvironmentObject var signupVM: SignUpViewModel
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            
            
                Image("welcome")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                .aspectRatio(contentMode: )
                .scaledToFill()
          
            letsGoBtn()
                .padding([.bottom, .top, .leading],50)
                .padding([.trailing], 20)
                
            
        }
        
        .ignoresSafeArea()
    }
}



extension WelcomeView {
    func letsGoBtn() -> some View {
    
            
            NavigationLink(
                destination: HideNavbarOf(view: WalkThrough1View())
            , label: {
                HStack{
            
                    Text("Let's Go")
                            .foregroundColor(.white)
                            .font(.custom("Nunito-Bold", size: 20))
//
                    Image("forward")
                }.foregroundColor(.blue)
            })
            
            
      
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
       
        WelcomeView()
       
    }
}
