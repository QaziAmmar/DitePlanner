//
//  LoginView.swift
//  dietPlanner
//
//  Created by Aqsa's on 15/09/2022.
//

import SwiftUI
import Firebase
struct LoginView: View {
    
    @StateObject var vm = LoginViewModel()

    var body: some View {
        loadView()
            .alert(isPresented: $vm.showError, content: {
                Alert(title: Text(vm.errorMessage))
            })   
    }
}



// View Extension
extension LoginView {
    
    func loadView() -> some View {
        ScrollView{
            VStack(){
                
                Image("loginimg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack(alignment: .leading){
                    
                    Text("Log In")
                        .font(.custom("Nunito-Bold", size: 24))
                        .padding([.horizontal])
                    
                    
                    VStack{
                        
                        textFields()
                        // Login Button
                        GreenBtn(action: {
                            vm.login()
                        }, title: "Login")
                        
                        HStack {
                            Spacer()
                            forgotPass()
                        }
                        
                        bars()
                        
                        GSignInButton(errorMessage: $vm.errorMessage, showError: $vm.showError)
                        AppleSignInButton(errorMessage: $vm.errorMessage, showError: $vm.showError)
                        

                        noAccountBtn().padding([.vertical],20)
                    }
                    .padding([.horizontal],30)
                    
                }.padding([.top],-10)
                
                
            }
        }
            .edgesIgnoringSafeArea(.top)
    }

    
    func textFields() -> some View {
        VStack(spacing: 15){
            CustomTextField(placeHolder: "Enter Email", text: $vm.email)
            PasswordTextField(title: "Password", placeHolder: "Enter you Password", text: $vm.password)
            
        }
    }
    
    func bars () -> some View {
        HStack{
            Rectangle()
                .fill(Color.black)
                .frame( height: 1)
            
            Text(" Or ")
                .font(.custom("Nunito-Bold", size: 15))
            
            Rectangle()
                .fill(Color.black)
                .frame( height: 1)
        }
    }
    
    func forgotPass() -> some View {
        NavigationLink(
            destination: WalkThrough1View()
            , label: {
                
                Text("Forgot Password?")
                    .font(.custom("Nunito-Bold", size: 16))
                    .foregroundColor(Color(ColorName.appGreen.rawValue))
            })
    }

    func noAccountBtn() -> some View {
        NavigationLink(
            destination: HideNavbarOf(view: SignUp()),
            label: {
                HStack{
                    Text("Don't have an account?")
                        .font(.custom(Nunito.Regular.rawValue, size: 15))
                        .foregroundColor(.black)
                    Text("Sign Up")
                        .foregroundColor(Color("btnBlue"))
                        .font(.custom(Nunito.Medium.rawValue, size: 15))
                }
            })
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
