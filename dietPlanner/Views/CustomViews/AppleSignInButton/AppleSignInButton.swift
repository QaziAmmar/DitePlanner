//
//  AppleSignInButton.swift
//  HTPlanner
//
//  Created by Qazi Ammar Arshad on 06/10/2022.
//

import SwiftUI

struct AppleSignInButton: View {

    @Binding var errorMessage: String
    @Binding var showError: Bool
    
    @ObservedObject var vm = AppleSignInViewModel()

    
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
                        Image(systemName: "applelogo")
                            .resizable()
                            .frame(width: 24, height: 30)
                        
                            .foregroundColor(.black)

                        Text("Sign in with Apple")
                            .foregroundColor(.black)
                    }
            }
        }.onAppear {
            errorMessage = vm.errorMessage
            showError = vm.showError
        }
    }
}

struct AppleSignInButton_Previews: PreviewProvider {
    static var previews: some View {
        AppleSignInButton(errorMessage: .constant("GSign In error"), showError: .constant(false))
    }
}
