//
//  EditProfileView.swift
//  dietPlanner
//
//  Created by Aqsa's on 26/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    @State private var showPicker = false
    @State private var inputImage: UIImage?
    
    @StateObject var vm = EditProfileViewModel()
    
    
    var body: some View {
        loadView()
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
            .sheet(isPresented: $showPicker) {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    inputImage = image
                    // send this image to server
                    vm.updateProfile(profile: image)
                }
            }
    }
}


extension EditProfileView {
    
    
    func loadView() -> some View {
        
        VStack(spacing: 0) {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, title: "Edit Profile")
            
            ScrollView {
                
                VStack(spacing: 0){
                    
                    userBar()
                    fields()
                    
                    
                    GreenBtn(action: {
                        vm.updateuser {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }, title: "Save")
                    .padding(.top, 30)
                    
                    
                }
            }.padding(.horizontal)
        }
        
        .background(Color("bgclr"))
    }
    
    
    func userBar() -> some View {
        
        HStack (){
            
            Text("Change Profile Picture")
                .font(.custom(Nunito.Bold.rawValue, size: 20))
            Spacer()
            
            ZStack(alignment: .bottom) {
                
                Button {
                    showPicker.toggle()
                } label: {
                    WebImage(url: URL(string: vm.user.image_url))
                                            .resizable()
                                            .placeholder(inputImage==nil ? Image("GenricPlaceHolder") : Image(uiImage: inputImage!))
                                            .indicator(.activity)
                                            .scaledToFill()
                                            .frame(width: 70, height: 70)
                                            .clipShape(Circle())
                }
                Image(systemName: "camera.circle.fill")
                    .foregroundColor(Color(ColorName.appAqua.rawValue))
                    .padding([.bottom], -5)
            }
        }
        
    }
    
    
    func fields() -> some View {
        VStack(spacing: 5){
            VStack(alignment: .leading) {
                Text("Name:")
                    .font(Font.custom(Nunito.Bold.rawValue, size: 20))
                CustomTextField(placeHolder: "Full Name", text: $vm.user.userName)
            }
            VStack(alignment: .leading) {
                Text("Email:")
                    .font(Font.custom(Nunito.Bold.rawValue, size: 20))
                
                CustomTextField(placeHolder: "Enter Phone or Email", text: $vm.user.userEmail)
            }
            
            VStack(alignment: .leading) {
                Text("Phone #:")
                    .font(Font.custom(Nunito.Bold.rawValue, size: 20))
                CustomTextField(placeHolder: "Phone Number", text: $vm.user.phone)
            }
            
            VStack(alignment: .leading) {
                Text("Age:")
                    .font(Font.custom(Nunito.Bold.rawValue, size: 20))
                CustomTextField(placeHolder: "Age", text: $vm.user.age)
            }
            
        }
    }
    
    
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
