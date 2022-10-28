//
//  GSignInButton.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 07/03/2022.
//

import SwiftUI

struct GSignInButton: View {
    

    @Binding var errorMessage: String
    @Binding var showError: Bool
    
    @ObservedObject var vm = GSignInViewModel()

    
    var body: some View {
        Button  {
            vm.signIn()
        } label: {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(.white ,lineWidth: 1))
                    
                    HStack (spacing: 10){
                        Image("google")
                            .frame(width: 24, height: 24)
                            .scaledToFill()
                        //                                .resizeFill
                        Text("Continue with google")
                            .foregroundColor(.black)
                    }
            }
        }.onAppear {
            errorMessage = vm.errorMessage
            showError = vm.showError
        }
    }
}

struct GSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        GSignInButton(errorMessage: .constant("GSign In error"), showError: .constant(false))
    }
}
