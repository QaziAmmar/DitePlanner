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
}


class UserDefaultManager {
    
    static let shared = UserDefaultManager()
    let userDefaults : UserDefaults = UserDefaults.standard
    
    // this will return the empty stirng if no value is founded into UserDefaults.
    var userId: String {
        // this is an testing id for user
        return UserDefaultManager.shared.getUser()?.firebaseID ?? "UfJI7ZLWggNKYWSZUafkpPmxjpy1"
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
        UserDefaultManager.Authenticated.send(false)
    }
    
    
    /// WalkThrough Data. If user pass through the walk through then it will not show it again to the user.
    func updateWalkThroughStatus(isSeen: Bool) {
        userDefaults.set(isSeen, forKey: UserDefaultEnum.walkThrough.rawValue)
    }
    func isWalkThrougViewed() -> Bool {
        return userDefaults.bool(forKey: UserDefaultEnum.walkThrough.rawValue)
    }
    
    /// End Walk Through Section
    
    
    func isNewDateStarted_DailyCheckList() -> (Bool, Int) {
        
        // here we can use dummy dates to check either our accomplishments are increasing day by day or not.
        let old_day = userDefaults.value(forKey: UserDefaultEnum.dayilyCheckList.rawValue) as? Int
        let current_day = DateManager.standard.getDayOfTheYear()
        
        
        // for first time login
        if old_day == nil {
            userDefaults.set(current_day, forKey: UserDefaultEnum.dayilyCheckList.rawValue)
            return (false, 0)
        }
        // find the difference between date
        let difference = current_day - old_day!
        
        if current_day == old_day {
            return (false, difference)
        } else {
            userDefaults.set(current_day, forKey: UserDefaultEnum.dayilyCheckList.rawValue)
            return (true, difference)
        }
            
    }
    
    
    func isNewDateStarted_ToDoList() -> Bool {
        
        let old_day = userDefaults.value(forKey: UserDefaultEnum.todoList.rawValue) as? Int
        let current_day = DateManager.standard.getDayOfTheYear()
        
        // for first time login
        if old_day == nil {
            userDefaults.set(current_day, forKey: UserDefaultEnum.todoList.rawValue)
            return false
        }
        
        if current_day == old_day {
            return false
        } else {
            userDefaults.set(current_day, forKey: UserDefaultEnum.todoList.rawValue)
            return true
        }
            
    }

}

