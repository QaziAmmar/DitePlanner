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
    
    @StateObject var goal_vm = GoalViewModel()
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
            
            
            NavigationLink {
                HideNavbarOf(view: SetCaloriesGoals(vm: goal_vm, type: DAILY, isNavigatedFromSignUp: true))
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .foregroundColor(Color(ColorName.appGreen.rawValue))
                    Text("Next")
                        .foregroundColor(.white)
                        .font(Font.custom(Nunito.Bold.rawValue, size: 20))
                }
            }
            
            
        }.padding()
    }
}
struct ChoseDislikeFood_Previews: PreviewProvider {
    static var previews: some View {
        ChoseDislikeFood(vm: PreferenceViewModel())
    }
}
