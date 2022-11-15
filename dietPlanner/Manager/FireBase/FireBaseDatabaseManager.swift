//
//  FireBaseDatabaseManager.swift
//  HTPlanner
//
//  Created by Qazi Ammar Arshad on 03/06/2022.
//


import Foundation

import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseSwift

import CoreLocation
import SwiftSpinner

enum InsertUserStatus {
    case success
    case alreadyExist
    case fail
}

/// Manager object to read and write data to real time firebase database
final class FirebaseDatabaseManager {
    
    /// Shared instance of class
    public static let shared = FirebaseDatabaseManager()
    
    // get current user
    let database = Database.database().reference()
    
    
    
    public enum DatabaseError: Error {
        case failedToFetch
        
        public var localizedDescription: String {
            switch self {
            case .failedToFetch:
                return "This means blah failed"
            }
        }
    }
}

// MARK: - Account Mgmt
extension FirebaseDatabaseManager {
    
    /// Inserts new user to database
    public func insertUser(with user: User, completion: @escaping (InsertUserStatus, String) -> Void) {
        
        
        database.child("Users").child(user.firebaseID).observeSingleEvent(of: .value) { data in
            if data.exists() {
                print("user alreay exist");
                completion(.alreadyExist, "")
                return
                
            } else {
        
                // create new user in database
                self.database.child("Users").child(user.firebaseID).setValue(user.convertToDictionary, withCompletionBlock: { error, _ in
                    
                    guard error == nil else {
                        completion(.fail, "failed to write to database")
                        return
                    }
                    
                    // create 2 table for each newly created table.
                    self.create_dislike_and_dite_preferences(fireBaseId: user.firebaseID)
                    completion(.success, "")

                })
                
            }
        }
    }
    
    
    public func updateUser(with user: User, completion: @escaping (Bool, String) -> Void) {
        
        SwiftSpinner.show("Updating User ...")
        database.child("Users").child(user.firebaseID).setValue(user.convertToDictionary!, withCompletionBlock: { error, _ in
            
            SwiftSpinner.hide()
            
            guard error == nil else {
                completion(false, "failed to write to database")
                return
            }
            completion(true, "")
            
        })
    }
    
    
    public func getUser(with firebaseID: String, completion: @escaping (Bool, String) -> Void) {
        
        database.child("Users").child(firebaseID).observeSingleEvent(of: .value) { snapshot in

            guard let value = snapshot.value as? [String: Any] else {
                completion(false, "user not found")
                return
            }
            
            do {
                
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                let user = try JSONDecoder().decode(User.self, from: jsonData)
                
                UserDefaultManager.shared.set(user: user)
                
                // read user's goals and update into usersDefaults.
                GoalViewModel().readGoals(type: DAILY)
                GoalViewModel().readGoals(type: WEEKLY)
                
                completion(true, "user login successfully")
                
            } catch let error {
                print(error)
                completion(false, error.localizedDescription)
            }
        }
        
    }
    
    public func deleteUser(with firebaseID: String, completion: @escaping (Bool, String) -> Void) {
        
        database.child("Users").child(firebaseID).removeValue { error, _  in
            if let error = error {
                completion(false, error.localizedDescription)
            } else {
                completion(true, "")
            }
        }
    }
}

/// This will create some table in firebase database for newly created person
// MARK: Auto Firebase Table Generation

extension FirebaseDatabaseManager {
    /// This will create dite preference and dislike food selection of each newly created user
    public func create_dislike_and_dite_preferences(fireBaseId: String) {
        
        print("create_dislike_and_dite_preferences")
        
        for preference in ditePreferenceArray {
            create_dite_preference(with: preference, firebaseID: fireBaseId)
        }
        
        for dislike in dislikeFoodArray {
            create_dislike_food(with: dislike, firebaseID: fireBaseId)
        }
        
        // create goal table
//        createDailyAndWeeklyGoal(fireBaseId: fireBaseId)
    }
    
     func create_dite_preference(with dietPreference: DitePreferenceModel, firebaseID: String) {
        
        database.child(FireBaseTable.dite_preferences.rawValue).child(firebaseID).childByAutoId().setValue(dietPreference.convertToDictionary!, withCompletionBlock: { error, _ in
            
            guard error == nil else {
                return
            }
        })
    }
    
     func create_dislike_food(with dislikeFood: DislikeFoodModel, firebaseID: String) {
        
        database.child(FireBaseTable.dislike_food.rawValue).child(firebaseID).childByAutoId().setValue(dislikeFood.convertToDictionary!, withCompletionBlock: { error, _ in
            
            guard error == nil else {
                return
            }
        })
    }
    
    /// This function will create the daily and weekly goald table for the new created user.
    func createDailyAndWeeklyGoal(fireBaseId: String) {
        
        print("Create Daily and Weekly Goal Table")
        let userID = UserDefaultManager.shared.userId
        // create daily goal
        database.child(FireBaseTable.goals.rawValue).child(userID).child(DAILY).setValue(Goals().convertToDictionary!, withCompletionBlock: { error, _ in
            
            guard error == nil else {
                return
            }
        })
        
        // create weekly goal table
        database.child(FireBaseTable.goals.rawValue).child(userID).child(WEEKLY).setValue(Goals().convertToDictionary!, withCompletionBlock: { error, _ in
            
            guard error == nil else {
                return
            }
        })
    }
    
    
}


// MARK: - Recipe Management
extension FirebaseDatabaseManager {
    
    
    public func insertRecipe(with recipe: RecipeModel, completion: @escaping (Bool, String) -> Void) {
        
        SwiftSpinner.show("Loading...")
        let userID = UserDefaultManager.shared.userId
        
        database.child(FireBaseTable.recipes.rawValue).child(userID).childByAutoId().setValue(recipe.convertToDictionary!, withCompletionBlock: { error, ref in
            
            SwiftSpinner.hide()
            
            guard error == nil else {
                completion(false, "failed to write to database")
                return
            }
            
            completion(true, ref.key ?? "no key found")
            
        })
    }
}


