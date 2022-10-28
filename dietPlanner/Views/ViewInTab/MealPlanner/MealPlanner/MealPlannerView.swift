//
//  MealPlannerView.swift
//  dietPlanner
//
//  Created by Aqsa's on 19/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MealPlannerView: View {
    
    @State private var isActive = false
    @State var menuOpen : Bool = false
    @State var currentTab: Int = 0
    
    @State private var mealType = 0
    
    //    Navigation Variables
    @State private var moveToPreferences = false
    @State private var moveToEditProfile = false
    @State private var moveToChangePassword = false
    @State private var moveToGoals = false
    
    //    ViewModel Object
    @StateObject var vm = MealPlannerViewModel()
    
    
    var body: some View {
        loadView()
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
            .background(
                hiddenNavigationLinks
            )
    }
    
}



// MAKR: UIView Extension
extension MealPlannerView {
    
    func loadView() -> some View {
        ZStack(){
            
            VStack {
                navBarView()
                
                ScrollView(showsIndicators: false){
                    
                    VStack{
                        
                        userBar()
                        
                        MyCalendarY(onDatePicked: { date in
                            print(date)
                        }).frame( height: 80)
                            .background(Color("bgclr"))
                        
                        HStack {
                            Text("Today's meals")
                                .font(.custom(Nunito.Semibold.rawValue, size: 18))
                            Spacer()
                        }
                        
                        HorizontalTabSelection(categores: vm.categories, selectedIndex: $vm.selectedCategory)
                        
                        TabView(selection: self.$currentTab) {
                            
                            BreakFastView().tag(0)
                            LunchView().tag(1)
                            DinnerView().tag(2)
                            SnackView().tag(3)
                        }.frame( height: 310)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        
                        
                        WeeklyPlanBtn()
                        
                        Spacer()
                        
                    }
                }
                
            }
            .padding()
            .background(Color("bgclr"))
            
            // sidemenu view
            ZStack {
                SideMenu(width: 300,
                         isOpen: self.menuOpen,
                         menuClose: self.openMenu,
                         onClick: { selectedView in
                    self.performNavigation(at: selectedView)
                })
            }
        }
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
    
    func WeeklyPlanBtn() -> some View {
        
        
        NavigationLink(destination: HideNavbarOf(view: WeeklyMealPlan())) {
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 5)
                    .stroke( .gray, lineWidth: 1)
                    .frame(height: 46)
                    .background(Color("bgclr"))
                
                HStack {
                    Text("Weekly Meal Plan")
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
        ZStack{
            HStack{
                
                if !self.menuOpen {
                    Button(action: {
                        self.openMenu()
                    },
                           label: {
                        
                        Image("Drawer")
                            .resizable()
                            .frame(width: 24.0, height: 24.0)
                    })
                    
                }
                Spacer()
                
            }
            Text("Meal Planner")
                .font(.custom(Nunito.Bold.rawValue, size: 22.5))
                .foregroundColor(Color(ColorName.appAqua.rawValue))
        }
    }
    
}

// MARK: - Custom Function Extesnion
extension MealPlannerView {
    
    
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
        
        MealPlannerView()
    }
}
