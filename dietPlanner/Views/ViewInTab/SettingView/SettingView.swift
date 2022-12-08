//
//  MoreView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 31/10/2022.
//

import SwiftUI

struct SettingView: View {
    
    
    //    Navigation Variables
    @State private var moveToPreferences = false
    @State private var moveToEditProfile = false
    @State private var moveToChangePassword = false
    @State private var moveToDailyGoals = false
    @State private var moveToWeeklyGoals = false
    
    @StateObject var vm = SettingViewModel()
    @State private var showAlert = false
    
    let settingMenuList = [SettingModel(title: "Profile Settings", subTitle: "Edit and make changes to your profile", image: "profile", type: .profileSetting),
                           SettingModel(title: "Preferences", subTitle: "Edit your food preference & Dislikes", image: "preferences", type: .preferences),
                           SettingModel(title: "Change Password", subTitle: "Change your password here", image: "changePassword", type: .changePassword),
                           SettingModel(title: "Calorie & Macro Daily Goals", subTitle: "Create Calorie & Macro Daily Goals", image: "dailyGoal", type: .dailyGoal),
//                           SettingModel(title: "Calorie & Macro Weekly Goals", subTitle: "Create Calorie & Macro Weekly Goals", image: "weeklyGoal", type: .weeklyGoal),
                           SettingModel(title: "Delete Account", subTitle: "We are really sorry to hear that", image: "deleteAccount", type: .deleteAccount)]
    
    var body: some View {
        loadView()
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))       
            }
            .alert("Are you sure to delete", isPresented: $showAlert) {
                Button("Yes", role: .destructive) {
                    vm.removeUser()
                }
            }
            .onAppear {
                vm.totalCalories = Int(UserDefaultManager.shared.getGoal(type: DAILY).calories * 5000)
                vm.consumedCalories = UserDefaultManager.shared.getTotalCalories()
            }
    }
}

// MARK: UIView extension
extension SettingView {
    
    func loadView() -> some View {
        
        VStack {
            navBarView()
                .padding(.vertical)

            ScrollView(showsIndicators: false) {
                
                todayProgressView()
                
                ForEach(settingMenuList) { settingmodel in
                    SettingRow(setting: settingmodel, onTap: { type in
                        handleNavigation(type: type)
                    })
                        .padding()
                }

                Button {
                    UserDefaultManager.shared.logout()
                } label: {
                    Text("Logout")
                        .font(.custom(Nunito.Medium.rawValue, size: 20))
                        .foregroundColor(Color(hex: "C50E0E"))
                }.padding(.vertical)
            }
        }.background(hiddenNavigationLinks)
    }
    
    func navBarView() -> some View {
        Text("Meal Planner")
            .font(.custom(Nunito.Bold.rawValue, size: 22.5))
            .foregroundColor(Color(ColorName.appAqua.rawValue))
    }
    
    func todayProgressView() -> some View {
        VStack {
            VStack {
                HStack {
                    Text("Today's Progress")
                        .font(.custom(Nunito.Bold.rawValue, size: 16))
                    Spacer()
                    HStack{
                        Text("🎉 Keep the pace! You’re doing great.")
                            .font(.custom(Nunito.Regular.rawValue, size: 8))
                    }
                }
                
                VStack {
                    Image(ImageName.calories.rawValue)
                        .resizable()
                        .frame(width:18, height: 21)
                        .background(
                            Circle()
                                .foregroundColor(Color("bgPurple"))
                                .padding(-10)
                        )
                    Text("Calories")
                        .padding(.top, 5)
                    Text("\(vm.totalCalories)")
                        .foregroundColor(Color("Purple"))
                }.padding(.top, 5)

                progressBar(name: "Remaining", calories: "\(vm.totalCalories - vm.consumedCalories) Kcal", color: .red, progress: (1 - vm.caloriesConsumedPercentage()) )
                progressBar(name: "Eaten 🍽️", calories: "\(vm.consumedCalories) Kcal", color: .green, progress: vm.caloriesConsumedPercentage())
                
            }.padding()
            
            .background(
                Rectangle()
                .cornerRadius(10, corners: .allCorners)
                .foregroundColor(.white)
                .shadow(radius: 3)
            )
            
        }.padding(10)
     
    }
    
    func progressBar(name: String, calories: String, color: Color, progress: Double) -> some View {

            VStack {
                HStack {
                    Text(name)
                    Spacer()
                    Text(calories)
                        .font(.custom(Nunito.Regular.rawValue, size: 12))
                        .foregroundColor(.gray)
                }
                ZStack {
                    GeometryReader { geo in
                        Rectangle()
                            .cornerRadius(5)
                            .foregroundColor(.gray.opacity(0.2))
                            
                        Rectangle()
                            .cornerRadius(5)
                            .foregroundColor(color.opacity(0.9))
//if progress < 0 then make progress 0
//                        if progress greate then 1 then  make progress 1
                            .frame(width: geo.size.width * (progress < 0.0 ? 0.0 : progress > 1 ? 1 : progress))
                    }
                        
                }
            }
        
        
    }
    
    var hiddenNavigationLinks: some View {
        
        ZStack() {
            NavigationLink("", destination: HideNavbarOf(view: ChangePreferenceView()) , isActive: $moveToPreferences)
            NavigationLink("", destination: HideNavbarOf(view: EditProfileView()), isActive: $moveToEditProfile)
            NavigationLink("", destination: HideNavbarOf(view: ChangePasswordView()), isActive: $moveToChangePassword)
            NavigationLink("", destination: HideNavbarOf(view: CalorieGoalView(type: DAILY)), isActive: $moveToDailyGoals)
//            NavigationLink("", destination: HideNavbarOf(view: CalorieGoalView(type: WEEKLY)), isActive: $moveToWeeklyGoals)
        }
        .hidden()
        .frame(height: 0)
    }
    
}

// MARK: Custom Function extension
extension SettingView {

    
    func handleNavigation(type: SettingType) {
        switch type {
        case .profileSetting:
            moveToEditProfile = true
        case .preferences:
            moveToPreferences = true
        case .changePassword:
            moveToChangePassword = true
        case .dailyGoal:
            moveToDailyGoals = true
        case .weeklyGoal:
            moveToWeeklyGoals = true
        case .deleteAccount:
            deleteAccount()
        }
    }
    
    func deleteAccount()  {
        showAlert.toggle()
    }
    
}


struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}


enum SettingType: String {
    case profileSetting
    case preferences
    case changePassword
    case dailyGoal
    case weeklyGoal
    case deleteAccount
}

struct SettingModel: Identifiable {
    var id = UUID().uuidString
    var title: String
    var subTitle: String
    var image: String
    var type: SettingType
    
}
