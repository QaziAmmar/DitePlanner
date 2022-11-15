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
    
    var body: some View {
        loadView()
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
                    self.presentationMode.wrappedValue.dismiss()
                }, title: "Goals")
                
                GoalSliderRow(text: "Calories", value: $vm.tempGoals.calories, color: .purple)
                GoalSliderRow(text: "Fats", value: $vm.tempGoals.fats, color: .red)
                GoalSliderRow(text: "Protein", value: $vm.tempGoals.protein, color: .yellow)
                GoalSliderRow(text: "Carbohydrates", value: $vm.tempGoals.carbohydrates, color: .green)
                    
                
                Spacer()
                
            }
        }
        
        
    }
}

struct SetCaloriesGoals_Previews: PreviewProvider {
    static var previews: some View {
        SetCaloriesGoals(vm: GoalViewModel(), type: DAILY)
    }
}
