//
//  MealPlannerViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 25/10/2022.
//



import Combine
import Foundation
import SwiftSpinner
import FirebaseDatabase
import FirebaseDatabaseSwift

class HomeViewModel: ObservableObject {
    
    
    @Published var categories = ["Breakfast", "Lunch", "Dinner", "Snack-Other"]
    @Published var selectedCategory = 0
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    
    @Published var breakFast = [RecipeModel]()
    @Published var lunch = [RecipeModel]()
    @Published var dinner = [RecipeModel]()
    @Published var snacks = [RecipeModel]()
    
    // Loading Variables for data
    @Published var isBreakFastLoading = false
    @Published var isLunchLoading = false
    @Published var isDinnerLoading = false
    @Published var isSnacksLoading = false
    
    // Firebase Variable
    private let userID = UserDefaultManager.shared.userId
    private let database = Database.database().reference()
    private let mealPlannerTable = FireBaseTable.mealPlanner.rawValue
    private let start_date_of_week = FireBaseTable.start_date_of_week.rawValue
    
    init() {
        addWeekStartDateToFierBase()
        // this function will run after each week and update your daily meal plan.
        updateWeeklyMealPlan()
    }
    
}


// MARK: Custom Function Extension
extension HomeViewModel {
    
    // show error
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }
    
}


// MARK: Recipe Firebase CRUD
extension HomeViewModel {
    
}

// MARK: Meal Planner Firebase CRUD
extension HomeViewModel {
    
    
    func fetchAllDayMeals(date: Date) {
        
        
        let strDate = DateManager.standard.getCurrentString(from: date)
        // fetech breakfast
        isBreakFastLoading = true
        database.child(mealPlannerTable).child(userID).child(categories[0]).child(strDate).observeSingleEvent(of: .value) { snapshot in
            // 5
            self.isBreakFastLoading = false
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            // 6
            self.breakFast = children.compactMap { snapshot in
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
        // fetch lunch
        isLunchLoading = true
        database.child(mealPlannerTable).child(userID).child(categories[1]).child(strDate).observeSingleEvent(of: .value) { snapshot in
            
            self.isLunchLoading = false
            // 5
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
            // 6
            self.lunch = children.compactMap { snapshot in
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
        // fetch dinner
        isDinnerLoading = true
        database.child(mealPlannerTable).child(userID).child(categories[2]).child(strDate).observeSingleEvent(of: .value) { snapshot in
            self.isDinnerLoading = false
            // 5
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            // 6
            self.dinner = children.compactMap { snapshot in
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
        // fetch snack
        isSnacksLoading = true
        database.child(mealPlannerTable).child(userID).child(categories[3]).child(strDate).observeSingleEvent(of: .value) { snapshot in
            // 5
            self.isSnacksLoading = false
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            // 6
            self.snacks = children.compactMap { snapshot in
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


// MARK: - Update weekly Meal plan view
extension HomeViewModel {
    // This function needs to update for date management.
    // it need to check the date form firebase if no date is founded in userDefaults
    func addWeekStartDateToFierBase() {
        
        let date = UserDefaultManager.shared.getStartDateOfWeek()
        
        // In the start no start_date_ofweek is added
        if date == nil {
            let currentDate = Date()
            let strDate = DateManager.standard.getCurrentString(from: currentDate)
            UserDefaultManager.shared.setStartDateOfWeek(date: currentDate)
            
            database.child(start_date_of_week).child(userID).setValue([
                "start_data_of_week": strDate
            ], withCompletionBlock: { error, ref in
                
            })
        }
    }
    
    // This function will update the daily plan list if old date is passed
    func updateWeeklyMealPlan() {
        
        if let previousWeekStartDate = UserDefaultManager.shared.getStartDateOfWeek() {
            // find the next date for the week.
            let calendar = Calendar.current
            let addOneWeekToCurrentDate = calendar.date(byAdding: .weekOfYear, value: 1, to: previousWeekStartDate)
            
            
                if previousWeekStartDate > addOneWeekToCurrentDate! {
                // call function to update week date and also update the meal planner accoding to new week.
                let currentDate = Date()
                UserDefaultManager.shared.setStartDateOfWeek(date: currentDate)
                addWeekStartDateToFierBase()
                // update the firebase mealplan according to week plan
                self.updateDailyMealPlaneWithWeeklyPlane()
            }
        }
    }
    
    
    /// This is a schedule function that will run after each week and update you meal plane
    func updateDailyMealPlaneWithWeeklyPlane() {
        
        //        1. fetach all weekly meal planes.
        //        2. add these weekly meal plan into daily Meal planner.
        
        let weeklyPlaneTable = FireBaseTable.weekly_meal_plan.rawValue
        let mealKeys: [String] = ["Breakfast", "Lunch", "Dinner", "Snack-Other"]
        let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        for meal in mealKeys {
            for weekDay in daysOfWeek {
                
                database.child(weeklyPlaneTable).child(userID).child(meal).child(weekDay).observeSingleEvent(of: .value) { snapshot in
                    // 5
                    guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                        return
                    }
                    // 6
                    _ = children.compactMap { snapshot in
                        // 7
                        do {
                            var recipe =  try snapshot.data(as: RecipeModel.self)
                            recipe.id = snapshot.ref.key
                            recipe.isPartOfDaliyPlan = false
                            // call function to add recipe from week plane to daily plane.
                            MealRecommendationViewModel().updateDailyMealPlannerWithWeeklyPlane(recipe: recipe, dayOfweek: weekDay, mealCategory: meal)
                            return recipe
                        } catch {
                            print(error)
                            return RecipeModel()
                        }
                    }
                }
            }
        }
    }
    
}


