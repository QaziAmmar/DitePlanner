//
//  LogUpView.swift
//  dietPlanner
//
//  Created by Aqsa's on 15/09/2022.
//

import SwiftUI
import Firebase
struct SignUp: View {
    
    
    @StateObject var vm = SignUpViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        loadView()
            .background(
                hiddenNavigationLinks
            )
    }
}



// MARK: View Extension
extension SignUp {
    
    func loadView() -> some View {
        ScrollView{
            VStack(){
                Image("logupimg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                VStack(alignment: .leading){
                    Text("Sign Up")
                        .font(.custom("Nunito-Bold", size: 24))
                        .padding([.vertical],-20)
                    VStack(spacing: 15){
                        fields()
                        
                        GreenBtn(action: {
                            vm.createUser()
                        }, title: "SIGN UP")
                        
                        bars()
                        
                        GSignInButton(errorMessage: $vm.errorMessage, showError: $vm.showError)
                        AppleSignInButton(errorMessage: $vm.errorMessage, showError: $vm.showError)
                        
                        noAccountBtn().padding([.vertical],20)
                    }.padding()
                }.padding([.horizontal])
                
                
            }
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
        }.ignoresSafeArea()
            .background(Color("bgclr"))
    }
    
    func fields() -> some View {
        VStack(spacing: 15){
            CustomTextField(placeHolder: "Full Name", text: $vm.name)
                .background(.white)
            CustomTextField(placeHolder: "Enter Phone or Email", text: $vm.email)
                .background(.white)
            CustomPasswordField( text: $vm.password, isSecured: true, placeHolder: "Password")
                .background(.white)
            CustomPasswordField(text: $vm.re_password, isSecured: true, placeHolder: "Confirm Password")
                .background(.white)
        }
    }
    
    func bars () -> some View {
        HStack{
            Rectangle()
                .fill(Color.black)
                .frame( height: 1)
            Text(" Or ")
                .font(.custom("Nunito-Bold", size: 16))
            Rectangle()
                .fill(Color.black)
                .frame( height: 1)
        }
    }
    
    
    func noAccountBtn() -> some View {
        
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack{
                Text("Already have an account?")
                    .font(.custom(Nunito.Regular.rawValue, size: 15))
                    .foregroundColor(.black)
                Text("Log In")
                    .foregroundColor(Color("btnBlue"))
                    .font(.custom(Nunito.Semibold.rawValue, size: 15))
            }
        }
    }
    
    var hiddenNavigationLinks: some View {
        
        ZStack() {
            NavigationLink("", destination: HideNavbarOf(view: ChosePreferenceView()) , isActive: $vm.moveToPreferenceView)
        }
        .hidden()
        .frame(height: 0)
    }
}



struct LogUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
