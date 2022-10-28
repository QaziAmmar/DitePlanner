//
//  AddRecipeView.swift
//  dietPlanner
//
//  Created by Aqsa's on 23/09/2022.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseStorage

struct AddRecipeView: View {
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var vm: RecipeViewModel
    @State var retrievedImages = [UIImage]()
    @State private var showPicker = false
    
    
    var body: some View {
        loadView()
    }
}


// MARK: UIView Extension
extension AddRecipeView {
    
    func loadView() -> some View {
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, title: "Add a Recipe")
            
            CustomTextField(placeHolder: "Enter recipe title here", text: $vm.recipeModel.name, background: Color(ColorName.appMain.rawValue))
            
            MLBTextEditor(title: "", text: $vm.recipeModel.details, placeholder: "Ingredients and the method of preparation...")
                .frame(maxHeight: 300)
            
            VStack(alignment: .leading) {
                Button {
                    showPicker.toggle()
                } label: {
                    ZStack {
                        if vm.recipeImage == nil {
                            Image("qorma")
                                .resizable()
                                .frame( height: 100)
                        } else {
                            Image(uiImage: vm.recipeImage!)
                                .resizable()
                                .frame( height: 100)
                        }
                        HStack{
                            Text("+").font(.custom(Nunito.Bold.rawValue, size: 22))
                                .foregroundColor(.white)
                            Text("Attach a Photo").font(.custom(Nunito.Regular.rawValue, size: 20))
                                .foregroundColor(.white)
                        }
                    }
                }
                
            }
            .padding([.top],30)
            
            
            Spacer()
            
            GreenBtn(action: {
                
                vm.createRecipe { status, message in
                    if status {
                        vm.recipeImage = nil
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.vm.showError(message: message)
                    }
                }

            }, title: "Save")
   
        }
        .padding()
        .sheet(isPresented: $showPicker) {
            ImagePickerView(sourceType: .photoLibrary) { image in
                vm.recipeImage = image
            }
        }
        .background(Color("bgclr"))
    }
    
    
}


struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(vm: RecipeViewModel())
    }
}
