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
