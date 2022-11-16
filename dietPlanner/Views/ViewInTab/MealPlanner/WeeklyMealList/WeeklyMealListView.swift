//
//  WeeklyMealListView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 10/11/2022.
//

import SwiftUI

struct WeeklyMealListView: View {
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var date = Date()
    @StateObject var vm = WeeklyMealListViewModel()
    
    var title: String
    var weeklyGoal = UserDefaultManager.shared.getGoal(type: WEEKLY)
    

    var body: some View {
        loadView()
            .onAppear{
                vm.fetchMealBy(dayofWeek: vm.dayOfWeek, mealCategory: title)
            }
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
            .onReceive(vm.$dayOfWeek) { newVale in
                vm.fetchMealBy(dayofWeek: vm.dayOfWeek, mealCategory: title)
            }
    }
}

//MARK: UIView Extension

extension WeeklyMealListView {
    func loadView() -> some View {

        VStack(alignment: .leading) {
            
            navBarView()
            WeekCalander(day: $vm.dayOfWeek)
                .padding(.horizontal)
            
            VStack {
                mealTitleView()
                mealList()
            }.padding(.horizontal)
            
        }
        
    }
    
    func navBarView() -> some View {
        
        HStack {
            
            // Back button
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image("back")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color(ColorName.appGreen.rawValue))
            }
            
            Spacer()
            Text(title)
                .font(.custom(Nunito.Bold.rawValue, size: 22.5))
                .foregroundColor(Color(ColorName.appAqua.rawValue))
            
            Spacer()
            
            NavigationLink(destination: HideNavbarOf(view: MealRecommendationView(title: title, dayofWeek: vm.dayOfWeek))) {
                Image(systemName: "plus")
                    .foregroundColor(Color(ColorName.appGreen.rawValue))
                    .frame(width: 20, height: 20)
            }
            
        }.padding()
    }
    
    
    func mealTitleView() -> some View {
        HStack {
            Text(title)
                .font(.custom(Nunito.Semibold.rawValue, size: 18))
                .padding(.vertical)
            Spacer()
            
            Text("\(vm.mealArray.count) meals | 870 calories")
                .foregroundColor(.gray)
                .font(Font.custom(Nunito.Regular.rawValue, size: 12))
        }
    }
        
    func mealList() -> some View {
        ScrollView {
            
            if vm.mealArray.isEmpty {
                Text("No Meal found")
            } else {
                
                ForEach(vm.mealArray) { recipe in
                    MealPlannerItemRow(recipe: recipe, onDelete: { recipe in
                        // on delete function
                        vm.removeMeal(recipe: recipe, dayOfweek: vm.dayOfWeek, mealCategory: title) { error, message in
                            if !error {
                                vm.showError(message: message)
                            } else {
                                vm.fetchMealBy(dayofWeek: vm.dayOfWeek, mealCategory: title)
                            }
                        }
                        // onDelete function End
                    })
                }
            }
            
            nutritionsIngradient()
        }
    }
    
    func nutritionsIngradient() -> some View {
        VStack(spacing: 5) {
            
            HStack {
                Text("Today Breakfast Nutritions")
                    .font(.custom(Nunito.Semibold.rawValue, size: 18))
                    .padding(.vertical, 10)
                Spacer()
            }
            HStack {
                Spacer()
                percentageView(nutration_name: "Calories", nutrationAmount: vm.calories)
                Spacer()
                percentageView(nutration_name: "Fats", nutrationAmount: vm.fat)
                Spacer()
                percentageView(nutration_name: "Protenis", nutrationAmount: vm.protein)
                Spacer()
                percentageView(nutration_name: "Carbo", nutrationAmount: vm.carbohydrates)
                Spacer()
            }
        }
    }
    
    func percentageView(nutration_name: String, nutrationAmount: Double) -> some View {
        
        HStack {
            ZStack{
                
                Circle()
                    .stroke(.gray, lineWidth: 2)
                    .frame(width: 75, height: 75)
                
                Circle()
                    .rotation(Angle(degrees: 270))
                    .trim(from: 0, to: CGFloat(getMealPercentage(name: nutration_name, value: nutrationAmount)))
                    .stroke(Color(ColorName.appGreen.rawValue), lineWidth: 2)
                    .frame(width: 75, height: 75)
                
                VStack(spacing: 0) {
                    Text(String(Int(nutrationAmount)))
                    HStack {
                        Text(nutration_name)
                            .font(Font.custom(Nunito.Medium.rawValue, size: 8))
                        Image(nutration_name.lowercased())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10, height: 10)
                    }
                }
            }
        }
    }
}

extension WeeklyMealListView {
    func getMealPercentage(name: String, value: Double) -> Double {
        
        var returnValue: Double = 0.0
        
        if name == "Carbo" {
            returnValue = weeklyGoal.carbohydrates
        } else if name == "Protenis" {
            returnValue = weeklyGoal.protein
        }else if name == "Calories" {
            returnValue = weeklyGoal.calories
        }else {
            returnValue = weeklyGoal.fats
        }
        
        returnValue = value / (returnValue * 5000)
        if returnValue.isNaN  || returnValue.isInfinite{
            return 0
        }
        return returnValue
    }
}


struct WeeklyMealListView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyMealListView(title: "Breakfast")
    }
}
