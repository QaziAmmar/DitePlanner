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
    @State private var moveToGoals = false
    
    let settingMenuList = [SettingModel(title: "Profile Settings", subTitle: "Edit and make changes to your profile", image: "profile", type: .profileSetting),
                           SettingModel(title: "Preferences", subTitle: "Edit your food preference & Dislikes", image: "preferences", type: .preferences),
                           SettingModel(title: "Change Password", subTitle: "Change your password here", image: "changePassword", type: .changePassword),
                           SettingModel(title: "Calorie & Macro Daily Goals", subTitle: "Create Calorie & Macro Daily Goals", image: "dailyGoal", type: .dailyGoal),
                           SettingModel(title: "Calorie & Macro Weekly Goals", subTitle: "Create Calorie & Macro Weekly Goals", image: "weeklyGoal", type: .weeklyGoal),
                           SettingModel(title: "Delete Account", subTitle: "We are really sorry to hear that", image: "deleteAccount", type: .deleteAccount)]
    
    var body: some View {
        loadView()
    }
}

// MARK: UIView extension
extension SettingView {
    
    func loadView() -> some View {
        
        VStack {
            navBarView()
                .padding(.vertical)
            
            ScrollView {
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
            moveToGoals = true
        case .weeklyGoal:
            moveToGoals = true
        case .deleteAccount:
            deleteAccount()
        }
    }
    
    func deleteAccount()  {
        print("delete my account")
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
