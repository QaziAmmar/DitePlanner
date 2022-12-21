//
//  CalorieGoalView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 28/10/2022.
//

import SwiftUI
import SwiftPieChart

struct CalorieGoalView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var vm = GoalViewModel()
    
    var type: String
    
    var body: some View {
        loadview()
            .onAppear {
                print("Calories Goal View appera")
                vm.readGoals(type: type)
            }
    }
}


// MAKR: UIView Extension
extension CalorieGoalView {
    
    func loadview() -> some View {
        GeometryReader { geometry in
            VStack {
                NavBar(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, title: "Calorie & Macro \(type) Goals")
                

                ScrollView(showsIndicators: false) {
                    VStack() {
                        planBtn()
                        PieChartView(
                            values: [Double(vm.goals.fats), Double(vm.goals.protein), Double(vm.goals.carbohydrates)] ,
                            colors: [Color.red, Color.yellow, Color.green, .purple],
                            names: ["Fat", "Protein", "Carbohydrates"],
                            backgroundColor: .white, innerRadiusFraction: 0.6)
                        .frame(height: geometry.size.height - 30)
                        
                    }
                }.padding(.horizontal)
            }
        }
        
    }
    
    
    func planBtn() -> some View {

        NavigationLink(destination: HideNavbarOf(view: SetCaloriesGoals(vm: vm, type: type))) {
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke( .gray, lineWidth: 1)
                    .frame(height: 46)
                
                HStack {
                    Text("Update Goals")
                        .foregroundColor(.gray)
                        .font(.custom("Nunito-Meduim", size: 16))
                    
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.gray)
                }.padding()
            }
        }
        
    }
    
    
}


struct CalorieGoalView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieGoalView(type: DAILY)
    }
}
