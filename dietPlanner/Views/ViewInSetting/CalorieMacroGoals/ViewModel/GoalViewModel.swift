//
//  CalorieGoalViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 15/11/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift

struct Goals: Codable {
    var calories: Double = 0.0
    var fats: Double = 0.0
    var protein: Double = 0.0
    var carbohydrates: Double = 0.0
}


class GoalViewModel: ObservableObject {
    
    
    @Published var goals = Goals()
    @Published var tempGoals = Goals()
    
    private let goalTable = FireBaseTable.goals.rawValue
    let userID = UserDefaultManager.shared.userId
    private let database = Database.database().reference()
}


// MARK: FireBase Crud Operation
extension GoalViewModel {
    
    func readGoals(type: String) {
        
        print("Read Goald with \(type)")
        
        database.child(goalTable).child(userID).child(type).observe(.value) { snapshot in
            // 5
            
            guard snapshot.children.allObjects is [DataSnapshot] else {
                return
            }
            
            do {
                self.goals =  try snapshot.data(as: Goals.self)
                /// need to improve this line below but hope so it does not effect the performance
                /// now we came with a soultion, this user default will add at very nice place.
                /// Whenereve new is logined we will call this function to get his weekly and daily goals
                UserDefaultManager.shared.setGoal(goal: self.goals, type: type)
            } catch {
                print(error)
                
            }
        }
    }
    
    func updateGoals(goal: Goals, type: String) {
            database.child(goalTable).child(userID).child(type).updateChildValues(goal.convertToDictionary!)
        
        database.child(goalTable).child(userID).child(type).updateChildValues(goal.convertToDictionary!) { error, ref in
            
            guard error == nil else {
                print("failed to update \(type) goal into to meal planner")
                return
            }
            
            UserDefaultManager.shared.setGoal(goal: self.goals, type: type)
        }
    }
    
}
