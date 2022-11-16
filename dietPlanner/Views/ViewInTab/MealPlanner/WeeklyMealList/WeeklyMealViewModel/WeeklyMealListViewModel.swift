//
//  WeeklyMealListViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 10/11/2022.
//

import Combine
import Foundation
import SwiftSpinner
import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation


class WeeklyMealListViewModel: ObservableObject {

    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var mealArray = [RecipeModel]()
    @Published var dayOfWeek = "Sun"
 
    // percentage View
    @Published var fat: Double = 0
    @Published var protein: Double = 0
    @Published var carbohydrates: Double = 0
    @Published var calories: Double = 0
    
    
    // Firebase Variable
    private let recipes = FireBaseTable.recipes.rawValue
    private let userID = UserDefaultManager.shared.userId
    private let database = Database.database().reference()
    private let weeklyPlaneTable = FireBaseTable.weekly_meal_plan.rawValue
    private let mealPlannerTable = FireBaseTable.mealPlanner.rawValue
    

}


// MARK: Custom Function Extension
extension WeeklyMealListViewModel {

    // show error
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }

}


// MARK: Recipe Firebase CRUD
extension WeeklyMealListViewModel {
    
    
    func fetchMealBy(dayofWeek: String, mealCategory: String) {

        
        database.child(weeklyPlaneTable).child(userID).child(mealCategory).child(dayofWeek).observeSingleEvent(of: .value) { snapshot in
            // 5
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            // 6
            self.mealArray = children.compactMap { snapshot in
                // 7
                do {
                    var recipe =  try snapshot.data(as: RecipeModel.self)
                    recipe.id = snapshot.ref.key
                    
                    self.fat = self.fat + (Double(recipe.fat) ?? 0)
                    self.calories = self.calories + (Double(recipe.calories) ?? 0)
                    self.carbohydrates = self.carbohydrates + (Double(recipe.carbohydrates) ?? 0)
                    self.protein = self.protein + (Double(recipe.protenis) ?? 0)
                    
                    return recipe
                } catch {
                    print(error)
                    return RecipeModel()
                }
            }
        }
    }
    
    func removeMeal(recipe: RecipeModel, dayOfweek: String, mealCategory: String, completion: @escaping (Bool, String) -> ()) {
        
        SwiftSpinner.show("Loading...")
        // use the same recipe id that we have save into the database
        database.child(weeklyPlaneTable).child(userID).child(mealCategory).child(dayOfweek).child(recipe.id!).removeValue { error, ref in
            
            SwiftSpinner.hide()
            
            guard error == nil else {
                completion(false, "failed to delete meal into to meal planner")
                return
            }
            self.removeDailyMealPlannerWithWeeklyPlane(recipe: recipe, dayOfweek: dayOfweek, mealCategory: mealCategory)
            
            print("meal deleted successfully")
            completion(true, ref.key ?? "no key found")
        }
    
    }
    
    // this function will synchronize the weekly meal planner with daily week plan.
    func removeDailyMealPlannerWithWeeklyPlane(recipe: RecipeModel, dayOfweek: String?, mealCategory: String) {
        
        // this line will get the date for day of the week.
        let dateOfWeekDay = DateManager.standard.getDateFromWeekDay(weekDay: dayOfweek ?? "Mon", date: UserDefaultManager.shared.getStartDateOfWeek() ?? Date())
        let strDate = DateManager.standard.getCurrentString(from: dateOfWeekDay)
        
        database.child(mealPlannerTable).child(userID).child(mealCategory).child(strDate).child(recipe.id!).removeValue()
        
    }
    
    
}
