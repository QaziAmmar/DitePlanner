//
//  ChangePasswordView.swift
//  dietPlanner
//
//  Created by Aqsa's on 26/09/2022.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var vm = ChangePasswordViewModel()
    
   
    var body: some View {
        loadView()
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
                    
            }
    }
}


extension ChangePasswordView {
    
    func loadView() -> some View {
        VStack {
            
                NavBar(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, title: "Edit Profile")
            
            VStack {
                
                PasswordTextField(placeHolder: "Enter current passowrd", text: $vm.oldPassword)
                PasswordTextField(placeHolder: "Enter new password", text: $vm.newPassword)
                PasswordTextField(placeHolder: "Confirm new password", text: $vm.retypePassword)
                
                Spacer()
                
                GreenBtn(action: {
                    vm.updateuser()
                }, title: "Change Password")
            }.padding([.horizontal, .bottom])
            
        }.background(Color("bgclr"))
    }
    
}


struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
