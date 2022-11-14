//
//  WeeklyMealPlan.swift
//  dietPlanner
//
//  Created by Aqsa's on 20/09/2022.
//

import SwiftUI

struct MealCategoryView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isActive = false
    var planType: String
    
    @ObservedObject var vm: HomeViewModel

    
    
    var body: some View {
        loadView()
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
    }
}


// MARK: UIVIew Extesnion


extension MealCategoryView {
    
    // replacement of view did load
    func loadView() -> some View {
        VStack{
            
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, title: "\(planType) Meal Plan")
            
            ScrollView{
                ForEach(vm.categories, id: \.self) { meal in
                    // navigation accordig to the selected type of the meal plan.
                    if planType == DAILY {
                        NavigationLink(destination: HideNavbarOf(view: DailyMealListView(title: meal)) ) {
                            mealCard(name: meal)
                        }
                    } else {
                        NavigationLink(destination: HideNavbarOf(view: WeeklyMealListView(title: meal)) ) {
                            mealCard(name: meal)
                        }
                    }
                    
                }
                
            }.padding(.horizontal)
        }
    }
    

    
    func mealCard(name: String) -> some View {
        ZStack(alignment: .topLeading){
            
            Image(name.replacingOccurrences(of: "/", with: ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.9), Color.white.opacity(0)]), startPoint: .top, endPoint: .center)

            
            Text(name)
                .font(.custom(Nunito.Semibold.rawValue, size: 20))
                .foregroundColor(.black)
                .padding()
       
        }.padding(.vertical, 7)
    }

}


struct WeeklyMealPlan_Previews: PreviewProvider {
    static var previews: some View {
        MealCategoryView(planType: "Daily", vm: HomeViewModel())
    }
}
