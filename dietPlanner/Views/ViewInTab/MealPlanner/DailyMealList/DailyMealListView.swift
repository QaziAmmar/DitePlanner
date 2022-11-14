//
//  MealSelectorView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 25/10/2022.
//

import SwiftUI

struct DailyMealListView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var date = Date()
    var title: String
    @StateObject var vm = DailyMealListViewModel()


    var body: some View {
        loadView()
            .onAppear{
                vm.fetchMealBy(date: date, mealCategory: title)
            }
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
    }
}

//MARK: UIView Extension

extension DailyMealListView {
    func loadView() -> some View {
        
        
        VStack(alignment: .leading) {
            
            navBarView()
            
            MyCalendarY(onDatePicked: { date in
                self.date = date
                vm.fetchMealBy(date: date, mealCategory: title)
            }).frame( height: 80)
            
            VStack {
                mealTitleView()
                mealList()
                
            }.padding()
            
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
            
            NavigationLink(destination: HideNavbarOf(view: MealRecommendationView(title: title, date: date))) {
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
                        if recipe.isPartOfDaliyPlan {
                            vm.removeMeal(recipe: recipe, date: date, mealCategory: title) { error, message in
                                if !error {
                                    vm.showError(message: message)
                                } else {
                                    vm.fetchMealBy(date: date, mealCategory: title)
                                }
                            }
                            
                        } else {
                            vm.showError(message: "This meal is part of your weekly plan, delete it from your weekly plan")
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
                percentageView(nutration_name: "Calories", nutrationAmount: "752")
                Spacer()
                percentageView(nutration_name: "Fats", nutrationAmount: "571")
                Spacer()
                percentageView(nutration_name: "Protenis", nutrationAmount: "10")
                Spacer()
                percentageView(nutration_name: "Carbo", nutrationAmount: "59")
                Spacer()
            }
        }
    }
    
    func percentageView(nutration_name: String, nutrationAmount: String) -> some View {
        
        HStack {
            ZStack{
                
                Circle()
                    .stroke(.gray, lineWidth: 2)
                    .frame(width: 75, height: 75)
                
                Circle()
                    .rotation(Angle(degrees: 270))
                    .trim(from: 0, to: 0.5)
                    .stroke(Color(ColorName.appGreen.rawValue), lineWidth: 2)
                    .frame(width: 75, height: 75)
                
                VStack(spacing: 0) {
                    Text(nutrationAmount)
                    
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



struct MealSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        DailyMealListView(title: "Breakfast")
    }
}
