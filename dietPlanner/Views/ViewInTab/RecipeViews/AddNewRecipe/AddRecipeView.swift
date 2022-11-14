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
    var recipeDifficulities = ["Easy", "Medium", "Hard"]
    
    var body: some View {
        loadView()
    }
}


// MARK: UIView Extension
extension AddRecipeView {
    
    func loadView() -> some View {
        
        
        GeometryReader { geometry in
            
            ScrollView {
                ZStack(alignment: .top) {
                    
                    VStack() {
                        
                        topImage(geometry: geometry)
                        
                        VStack {
                            
                            CustomTextField(placeHolder: "Enter recipe title here", text: $vm.recipeModel.name)
                            foodNuterients()
                            
                            CustomTextField(placeHolder: "30 Min", text: $vm.recipeModel.makeTime)
                            
                            MenuSelection(itemArray: recipeDifficulities, placeholder: "Easy", selection: $vm.recipeModel.make_difficulity)
                            
                            MLBTextEditor(title: "", text: $vm.recipeModel.details, placeholder: "Ingredients and the method of preparation...")
                                .frame(height: 200)
                            
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
                        .background(
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(30, corners: [.topLeft, .topRight])
                                .padding(-20)
                        )
                        .padding()
                        .offset(y: -65)
                        .padding(.bottom, -65)
                        
                    }
                    
                    NavBar(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, title: "")
                    .padding(.top, 40)
                    
                }
                .frame(width: geometry.size.width)
                
            }
            .edgesIgnoringSafeArea(.top)
            .sheet(isPresented: $showPicker) {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    vm.recipeImage = image
                }
            }
        }
    }
    
    
    /// use to selet the image for recipe
    func topImage(geometry: GeometryProxy) -> some View {
        Button {
            showPicker.toggle()
        } label: {
            
            if vm.recipeImage == nil {
                ZStack {
                    Image(ImageName.genricPlaceHolder.rawValue)
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height / 2.3)
                        .clipped()
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Image")
                    }.foregroundColor(Color(ColorName.appGreen.rawValue))
                }
                
            } else {
                Image(uiImage: vm.recipeImage!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height / 2.3)
                    .clipped()
            }
        }
    }
    
    func foodNuterients() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            CustomDivider()
                .frame(height: 3)
                .padding(.vertical)
            
            Text("Food Nutrients")
                .font(Font.custom(Nunito.Bold.rawValue, size: 20))
            FoodNutrientsTextField(text: $vm.recipeModel.calories, title: "Calories")
            FoodNutrientsTextField(text: $vm.recipeModel.protenis, title: "Protenis")
            FoodNutrientsTextField(text: $vm.recipeModel.fat, title: "Fat")
            FoodNutrientsTextField(text: $vm.recipeModel.carbohydrates, title: "Carbohydrates")
            
        }
    }
    
}


struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(vm: RecipeViewModel())
    }
}
