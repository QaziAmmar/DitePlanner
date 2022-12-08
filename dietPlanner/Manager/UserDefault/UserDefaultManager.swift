//
//  UserDefaultManager.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 03/03/2022.
//

import Foundation
import Combine
import SwiftUI
import GoogleSignIn

enum UserDefaultEnum: String {
    case token
    case username
    case password
    case picture
    case userModel
    case dayilyCheckList
    case todoList
    case walkThrough
    case startDateOfWeek
    // goals
    case dailyGoal
    case weeklyGoal
//    today's total calories
    case totalCalories
}


class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    let userDefaults : UserDefaults = UserDefaults.standard
    
    // this will return the empty stirng if no value is founded into UserDefaults.
    var userId: String {
        // this is an testing id for user
        return UserDefaultManager.shared.getUser()?.firebaseID ?? "No_id_Founded"
    }
    // this will return the empty stirng if no value is founded into UserDefaults.
    var userName: String {
        return UserDefaultManager.shared.getUser()?.userName ?? ""
    }
    // return the saved password into the UserDefaults
    var age: String {
        return UserDefaultManager.shared.getUser()?.age ?? ""
    }
    // return the saved password into the UserDefaults
    var email: String {
        return UserDefaultManager.shared.getUser()?.userEmail ?? ""
    }
    
    var img_url: String {
        return UserDefaultManager.shared.getUser()?.image_url ?? ""
    }
    // return the saved password into the UserDefaults
 
    

    static let Authenticated = PassthroughSubject<Bool, Never>()
    
    static func IsAuthenticated() -> Bool {
        //this means that userDefaults have some data
        return shared.getUser() != nil
    }
    
    /// save user object into userDefaults
    func set(user: User) {
        // save complete userModel object into user Default.
        // structures cannot save into userDefaults so we need to convert them into
        // data before saving into usersDefaults.
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            userDefaults.set(encoded, forKey: UserDefaultEnum.userModel.rawValue)
        }

    }
    
    /// get the whole userObject form userDefaults.
    func getUser() -> User? {
   
        if let userData: Data =  userDefaults.object(forKey: UserDefaultEnum.userModel.rawValue) as? Data {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: userData) {
                return user
            }
            print("User Decoder Error")
        }
        print("User Not Found in UsersDefaults")
        return nil
    }
    
    
    
    /// Update username and save the new value into userDefaults
    func update(name: String) {
        var user = self.getUser()
        user?.userName = name
        self.set(user: user!)
    }
    
    
    
    func logout() {
        removeUser()
    }
    
    /// Remove all the user infor from the userDefault
    func removeUser() {
        GIDSignIn.sharedInstance.signOut()
        userDefaults.removeObject(forKey: UserDefaultEnum.userModel.rawValue)
        // these are user daily and weekly goals
        userDefaults.removeObject(forKey: DAILY)
        userDefaults.removeObject(forKey: WEEKLY)
        // Delete user start date of the current week.
        userDefaults.removeObject(forKey: UserDefaultEnum.startDateOfWeek.rawValue)
        userDefaults.removeObject(forKey: UserDefaultEnum.startDateOfWeek.rawValue)
        UserDefaultManager.Authenticated.send(false)
    }
    
    
    /// WalkThrough Data. If user pass through the walk through then it will not show it again to the user.
    func updateWalkThroughStatus(isSeen: Bool) {
        userDefaults.set(isSeen, forKey: UserDefaultEnum.walkThrough.rawValue)
    }
    func isWalkThrougViewed() -> Bool {
        return userDefaults.bool(forKey: UserDefaultEnum.walkThrough.rawValue)
    }

    //
    // these user defaults save the date from where you week is started. then use this
    //    date as referce to automatically generate the weekly meal plan.
    func setStartDateOfWeek(date: Date) {
        userDefaults.set(date, forKey: UserDefaultEnum.startDateOfWeek.rawValue)
    }
    func getStartDateOfWeek() -> Date? {
        return userDefaults.value(forKey: UserDefaultEnum.startDateOfWeek.rawValue) as? Date
    }
    

}


//  MARK: Goals Extension
extension UserDefaultManager {
    
    /// save user Daily goals
    func setGoal(goal: Goals, type: String) {
        // save complete userModel object into user Default.
        // structures cannot save into userDefaults so we need to convert them into
        // data before saving into usersDefaults.
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(goal) {
            userDefaults.set(encoded, forKey: type)
        }
    }
    
    /// get the whole userObject form userDefaults.
    func getGoal(type: String) -> Goals {
   
        if let userData: Data =  userDefaults.object(forKey: type) as? Data {
            let decoder = JSONDecoder()
            if let goal = try? decoder.decode(Goals.self, from: userData) {
                return goal
            }
            print("Goal Decoder Error")
        }
        print("No Goal Found in UsersDefaults")
        return Goals()
    }
    
    
    /// save user Daily goals
    func setTotalCalories(calories: Int) {
        userDefaults.set(calories, forKey: UserDefaultEnum.totalCalories.rawValue)
    }
    
    func getTotalCalories() -> Int {
        userDefaults.integer(forKey: UserDefaultEnum.totalCalories.rawValue)
    }
}

