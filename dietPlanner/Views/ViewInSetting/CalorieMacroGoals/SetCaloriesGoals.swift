//
//  SetCaloriesGoals.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 15/11/2022.
//

import SwiftUI
import Sliders

struct SetCaloriesGoals: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var vm: GoalViewModel
    var type: String
    @State private var showAlert = false
    @State private var isAlertShown = false
    
    var isNavigatedFromSignUp = false
    
    
    var body: some View {
        loadView()
        
            .sheet(isPresented: $showAlert) {
                CalorieAlertView().onDisappear {
                    isAlertShown = true
                }
            }
            .onAppear {
                vm.tempGoals = vm.goals
            }
            .onDisappear {
                vm.updateGoals(goal: vm.tempGoals, type: type)
            }
    }
}

// MAKR: UIView Extension
extension SetCaloriesGoals {
    func loadView() -> some View {
        
        GeometryReader { geometry in
            VStack {
                NavBar(action: {
                    
                    if isAlertShown {
                        self.presentationMode.wrappedValue.dismiss()
                        
                    } else {
                        
                        //                    5000
                        if (vm.tempGoals.calories * 5000) < 1000 {
                            showAlert.toggle()
                        } else {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    
                    
                    
                }, title: "Goals")
                
                GoalSliderRow(text: "Calories", value: $vm.tempGoals.calories, color: .purple)
                GoalSliderRow(text: "Fats", value: $vm.tempGoals.fats, color: .red)
                GoalSliderRow(text: "Protein", value: $vm.tempGoals.protein, color: .yellow)
                GoalSliderRow(text: "Carbohydrates", value: $vm.tempGoals.carbohydrates, color: .green)
                
                Spacer()
                
                // Show this button only when you login for the first time.
                if isNavigatedFromSignUp {
                    GreenBtn(action: {
                        // change root controller of the application
                        vm.updateGoals(goal: vm.tempGoals, type: type)
                        UserDefaultManager.Authenticated.send(true)
                    }, title: "Save Preferences")
                    .padding()
                }
            }
        }
        
        
    }
}

struct SetCaloriesGoals_Previews: PreviewProvider {
    static var previews: some View {
        SetCaloriesGoals(vm: GoalViewModel(), type: DAILY)
    }
}
