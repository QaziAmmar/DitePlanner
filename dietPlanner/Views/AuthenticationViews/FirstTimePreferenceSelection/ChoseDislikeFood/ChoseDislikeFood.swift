//
//  ChoseDislikeFood.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 27/10/2022.
//

import SwiftUI

struct ChoseDislikeFood: View {
    
    @ObservedObject var vm: PreferenceViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        loadView()
            .background(Color(ColorName.appMain.rawValue))
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
    }
}


// MARK: View Extension
extension ChoseDislikeFood {
    
    func loadView() -> some View {
        VStack {
            
            NavBar(action: {
                presentationMode.wrappedValue.dismiss()
            }, title: "Food Dislikes")

            if vm.dislike_foods.isEmpty {
                Text("Loading ..")
            } else {
                DislikeFoodList(vm: vm)
            }

            Spacer()
            
            GreenBtn(action: {
                // change root controller of the application
                UserDefaultManager.Authenticated.send(true)
            }, title: "Save Preferences")
            
            
        }.padding()
    }
}
struct ChoseDislikeFood_Previews: PreviewProvider {
    static var previews: some View {
        ChoseDislikeFood(vm: PreferenceViewModel())
    }
}
