//
//  MealPlannerView.swift
//  dietPlanner
//
//  Created by Aqsa's on 19/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @State private var isActive = false
    @State var menuOpen : Bool = false
    @State var currentTab: Int = 0
    
    @State private var mealType = 0
    @State private var date = Date()
    
    //    Navigation Variables
    @State private var moveToPreferences = false
    @State private var moveToEditProfile = false
    @State private var moveToChangePassword = false
    @State private var moveToGoals = false
    
    //    ViewModel Object
    @StateObject var vm = HomeViewModel()
    
    
    var body: some View {
        loadView()
            .onAppear{
                vm.fetchAllDayMeals(date: date)
            }
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
            .background(
                hiddenNavigationLinks
            )
    }
}


// MAKR: UIView Extension
extension HomeView {
    
    func loadView() -> some View {
        VStack {
            navBarView()
            
            ScrollView(showsIndicators: false){
                
                VStack(alignment: .leading){
                    
                    userBar()
                    
                    MyCalendarY(onDatePicked: { date in
                        self.date = date
                        vm.fetchAllDayMeals(date: date)
                    }).frame( height: 90)
                    
                    HStack {
                        Text(DateManager.standard.getCurrentString(from: date) == DateManager.standard.getCurrentString(from: Date()) ? "Today's meals" : DateManager.standard.getCurrentString(from: date))
                            .font(.custom(Nunito.Semibold.rawValue, size: 18))
                            .padding(.vertical)
                    }
                    
                    VStack(alignment: .leading) {
                        ActiveMealRow(mealList: vm.breakFast, isLoading: $vm.isBreakFastLoading, title: "Breakfast")
                        ActiveMealRow(mealList: vm.lunch, isLoading: $vm.isLunchLoading, title: "Lunch")
                        ActiveMealRow(mealList: vm.dinner, isLoading: $vm.isDinnerLoading, title: "Dinner")
                        ActiveMealRow(mealList: vm.snacks, isLoading: $vm.isSnacksLoading, title: "Snack-Other")
                    }
                    
                    
                    planBtn(type: DAILY)
                        .padding(.top)
                    planBtn(type: WEEKLY)
                    
                    Spacer()
                    
                }
            }
        }
        .padding()
    }
    
    
    func userBar() -> some View {
        VStack{
            HStack (){
                VStack(alignment: .leading) {
                    Text("Meals")
                        .font(.custom(Nunito.Bold.rawValue, size: 22))

                    Text("Stay Healthy with good diet.")
                        .font(.custom(Nunito.Regular.rawValue, size: 16))
                }
                Spacer()
                WebImage(url: URL(string: UserDefaultManager.shared.img_url))
                                        .resizable()
                                        .placeholder(Image("GenricPlaceHolder"))
                                        .indicator(.activity)
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
            }
            Divider()
        }
    }
    
    func planBtn(type: String) -> some View {
        
        
        NavigationLink(destination: HideNavbarOf(view: MealCategoryView(planType: type, vm: vm))) {
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke( .gray, lineWidth: 1)
                    .frame(height: 46)
                
                HStack {
                    Text("\(type) Meal Plan")
                        .foregroundColor(.gray)
                        .font(.custom("Nunito-Meduim", size: 16))
                    
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.gray)
                }.padding()
            }
        }
        
    }
    
    
    func navBarView() -> some View {
        Text("Meal Planner")
            .font(.custom(Nunito.Bold.rawValue, size: 22.5))
            .foregroundColor(Color(ColorName.appAqua.rawValue))
    }
    
}

// MARK: - Custom Function Extesnion
extension HomeView {
    
    
    // function to open/close menu
    func openMenu() {
        self.menuOpen.toggle()
    }
    
    func performNavigation(at view: NavViews) {
        self.menuOpen.toggle()
        switch view {
        case .preferences:
            moveToPreferences = true
        case .edit_profile:
            moveToEditProfile = true
        case .change_password:
            moveToChangePassword = true
        case .logout:
            UserDefaultManager.shared.logout()
        case .goals:
            moveToGoals = true
        }
    }
    
    var hiddenNavigationLinks: some View {
        
        ZStack() {
            NavigationLink("", destination: HideNavbarOf(view: ChangePreferenceView()) , isActive: $moveToPreferences)
            NavigationLink("", destination: HideNavbarOf(view: EditProfileView()), isActive: $moveToEditProfile)
            NavigationLink("", destination: HideNavbarOf(view: ChangePasswordView()), isActive: $moveToChangePassword)
            NavigationLink("", destination: HideNavbarOf(view: CalorieGoalView()), isActive: $moveToGoals)
        }
        .hidden()
        .frame(height: 0)
    }
}



struct MealPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeView()
    }
}
