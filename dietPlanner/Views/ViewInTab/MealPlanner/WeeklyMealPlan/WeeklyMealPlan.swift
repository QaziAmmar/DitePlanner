//
//  WeeklyMealPlan.swift
//  dietPlanner
//
//  Created by Aqsa's on 20/09/2022.
//

import SwiftUI

struct WeeklyMealPlan: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var firebaseId: String = ""
    @State private var isActive = false
    
    
    @StateObject var vm =  WeeklyMealPlaneViewModel()
    
    
    var body: some View {
        loadView()
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
            .background(Color(ColorName.appMain.rawValue))
    }
}


// MARK: UIVIew Extesnion


extension WeeklyMealPlan {
    
    // replacement of view did load
    func loadView() -> some View {
        VStack{
            
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, title: "Weekly Meal Plan")
            
            ScrollView{
                ForEach(vm.mealName, id: \.self) { meal in
                    NavigationLink(destination: HideNavbarOf(view: MealSelectorView(title: meal))) {
                        mealCard(name: meal)
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
            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(1), Color.white.opacity(0)]), startPoint: .top, endPoint: .center)

            
            Text(name)
                .font(.custom(Nunito.Semibold.rawValue, size: 20))
                .foregroundColor(.black)
                .padding()
       
        }.padding(.vertical, 7)
    }

}


struct WeeklyMealPlan_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyMealPlan(firebaseId: "dfsd")
    }
}
