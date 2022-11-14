//
//  MealRecommendationViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 04/11/2022.
//


import Combine
import Foundation
import SwiftSpinner
import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation

class MealRecommendationViewModel: ObservableObject {

    
    @Published var categories = ["Breakfast", "Lunch", "Dinner", "Snack-Other"]
    @Published var selectedCategory = 0
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false

    
    @Published var myRecipes = [RecipeModel]()
 
    
    // Firebase Variable
    private let recipes = FireBaseTable.recipes.rawValue
    private let userID = UserDefaultManager.shared.userId
    private let database = Database.database().reference()
    private let mealPlannerTable = FireBaseTable.mealPlanner.rawValue
    private let weekly_meal_plan_table = FireBaseTable.weekly_meal_plan.rawValue
    

}


// MARK: Custom Function Extension
extension MealRecommendationViewModel {

    // show error
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }

}


// MARK: Recipe Firebase CRUD
extension MealRecommendationViewModel {
    
    
    func fetchMyRecipes() {

        database.child(recipes).child(userID).observeSingleEvent(of: .value) { snapshot in
            // 5
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            // 6
            self.myRecipes = children.compactMap { snapshot in
                // 7
                do {
                    var recipe =  try snapshot.data(as: RecipeModel.self)
                    recipe.id = snapshot.ref.key
                    return recipe
                } catch {
                    print(error)
                    return RecipeModel()
                }
            }
        }
    }
}

// MARK: Meal Planner Firebase CRUD
extension MealRecommendationViewModel {
    
    
    /// This function is performating two function
    /// 1. its is adding meal into daily plane
    /// 2. its also adding meal into weekly plane
    /// The decision base on the type of variable.
    ///     if date is not null then add into daily meal plane
    ///     if dayOfweek is not null then add into Weekly meal plane
    func addMeal(recipe: RecipeModel, date: Date?, dayOfweek: String?, mealCategory: String, completion: @escaping (Bool, String) -> ()) {

        
        if date != nil {
            // add recipe into daliy plane
            let strDate = DateManager.standard.getCurrentString(from: date!)
            SwiftSpinner.show("Loading...")
            // use the same recipe id that we have save into the database
            database.child(mealPlannerTable).child(userID).child(mealCategory).child(strDate).child(recipe.id!).setValue(recipe.convertToDictionary!, withCompletionBlock: { error, ref in
                
                SwiftSpinner.hide()
                
                guard error == nil else {
                    completion(false, "failed to add meal into to meal planner")
                    return
                }
                
                completion(true, ref.key ?? "no key found")
                
            })
            
        } else {
            
            // add meal into weekly plane.
            SwiftSpinner.show("Loading...")
            // make this recipe as a part of weekly plan.
            var weeklyRecipe = recipe
            weeklyRecipe.isPartOfDaliyPlan = false
            
            // use the same recipe id that we have save into the database
            database.child(weekly_meal_plan_table).child(userID).child(mealCategory).child(dayOfweek!).child(recipe.id!).setValue(weeklyRecipe.convertToDictionary!, withCompletionBlock: { error, ref in
                
                SwiftSpinner.hide()
                
                guard error == nil else {
                    completion(false, "failed to add meal into to meal planner")
                    return
                }
                self.updateDailyMealPlannerWithWeeklyPlane(recipe: weeklyRecipe, dayOfweek: dayOfweek, mealCategory: mealCategory)
                completion(true, ref.key ?? "no key found")
                
            })
        }
    }
    
    // this function will update the daily meal planner once a new weekly plan is added.
    func updateDailyMealPlannerWithWeeklyPlane(recipe: RecipeModel, dayOfweek: String?, mealCategory: String) {
        
        // this line will get the date for day of the week.
        let dateOfWeekDay = DateManager.standard.getDateFromWeekDay(weekDay: dayOfweek ?? "Mon", date: UserDefaultManager.shared.getStartDateOfWeek() ?? Date())
        
        let strDate = DateManager.standard.getCurrentString(from: dateOfWeekDay)
        
        database.child(mealPlannerTable).child(userID).child(mealCategory).child(strDate).child(recipe.id!).setValue(recipe.convertToDictionary!, withCompletionBlock: { error, ref in

            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            
        })
        
    }
    
    
    
}
