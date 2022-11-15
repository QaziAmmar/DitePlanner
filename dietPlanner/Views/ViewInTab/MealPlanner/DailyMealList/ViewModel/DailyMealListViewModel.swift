//
//  MealSelectorViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 25/10/2022.
//

import Combine
import Foundation
import SwiftSpinner
import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation

class DailyMealListViewModel: ObservableObject {

    @Published var errorMessage: String = ""
    @Published var showError: Bool = false

    
    @Published var mealArray = [RecipeModel]()
    
    @Published var fat: Double = 0
    @Published var protein: Double = 0
    @Published var carbohydrates: Double = 0
    @Published var calories: Double = 0
 
    
    // Firebase Variable
    private let recipes = FireBaseTable.recipes.rawValue
    private let userID = UserDefaultManager.shared.userId
    private let database = Database.database().reference()
    private let mealPlannerTable = FireBaseTable.mealPlanner.rawValue
    

}


// MARK: Custom Function Extension
extension DailyMealListViewModel {

    // show error
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }

}


// MARK: Recipe Firebase CRUD
extension DailyMealListViewModel {
    
    
    func fetchMealBy(date: Date, mealCategory: String) {
        // these variables are use to show the total of the current calories
        self.fat = 0
        self.calories = 0
        self.carbohydrates = 0
        self.protein = 0

        let strDate = DateManager.standard.getCurrentString(from: date)
        
        database.child(mealPlannerTable).child(userID).child(mealCategory).child(strDate).observeSingleEvent(of: .value) { snapshot in
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
    
    func removeMeal(recipe: RecipeModel, date: Date, mealCategory: String, completion: @escaping (Bool, String) -> ()) {

        
        let strDate = DateManager.standard.getCurrentString(from: date)
        
        SwiftSpinner.show("Loading...")
        // use the same recipe id that we have save into the database
        database.child(mealPlannerTable).child(userID).child(mealCategory).child(strDate).child(recipe.id!).removeValue { error, ref in
            
            SwiftSpinner.hide()
            
            guard error == nil else {
                completion(false, "failed to delete meal into to meal planner")
                return
            }
            print("meal deleted successfully")
            completion(true, ref.key ?? "no key found")
        }
    
    }
    
}

// MARK: Meal Planner Firebase CRUD
extension DailyMealListViewModel {
    
    
}
