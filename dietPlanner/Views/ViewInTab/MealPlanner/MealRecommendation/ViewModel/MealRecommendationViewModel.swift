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
    @Published var portionOfMealSelected = "1"
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var noMyRecipesFound = false
    
    // this varibale is use to navigatio to detail view after a product is founded in online barcode database
    @Published var moveMealDetailView = false
    // we will take the proudct form online barcode database and then transformed it into our Recipted model
    @Published var transformedRecipeModel = RecipeModel()
    
    @Published var myRecipes = [RecipeModel]()
    @Published var others_Recipes = [RecipeModel]()
 
    
    // Firebase Variable
    private let recipes = FireBaseTable.recipes.rawValue
    private let userID = UserDefaultManager.shared.userId
    private let database = Database.database().reference()
    private let mealPlannerTable = FireBaseTable.mealPlanner.rawValue
    private let weekly_meal_plan_table = FireBaseTable.weekly_meal_plan.rawValue
    

}


// MARK: Custom Function Extension
extension MealRecommendationViewModel {
    
    
//    convert fraction into decimal
    
    func convertFractionInToDecimal(fraction: String) -> Float {

        if fraction.isEmpty {
            return 1.0
        }
        
        if fraction.count == 1 {
            return 1.0
        }
        
        let comps = fraction.components(separatedBy: "/")

       //Do some validation here so as to check the correct format of fraction text.

        let op1 = NSString(string: comps[0]).floatValue
        let op2 = NSString(string: comps[1]).floatValue

       return op1/op2

    }

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
            
            if children.count == 0 {
                self.noMyRecipesFound = true
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
    
    func fetchOthersRecipes() {

//        Problems
        /// Need to make a schema where I can get the recipes of other uses with some sort of pagination
        /// 1. get all the childes of other uses and
        /// 2. get the recipes of other user.
        /// 3. this function need to be cached we will update data in cache.
//        Solution
        ///1. fetch all the users, and exclude if current userID match with any of them.
        ///
        var userIDs: [String] = []
        
        // fetching randomly user's IDs.
        database.child(recipes).observeSingleEvent(of: .value) { snapshot in
            // 5
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            // 6
            userIDs = children.compactMap { snapshot in
                // 7
                let userId = snapshot.key
                return userId
            }
            
            // fetch recipes with paginate
            self.manageOtherUserId(otherUsersId: userIDs)
        }
    }
    
    func manageOtherUserId(otherUsersId: [String]) {
        // exclude self id if exist.
        let filteredId = otherUsersId.filter { $0 != userID }
        
//        Now iterate throught these ids and append it into the recommend recipes
        for id in filteredId {
            fetchRecipesWith(otherId: id)
        }

    }
    
    func fetchRecipesWith(otherId: String) {
        
        database.child(recipes).child(otherId).observeSingleEvent(of: .value) { snapshot in
            // 5
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            var tempRecipes = [RecipeModel]()
            // 6
            tempRecipes = children.compactMap { snapshot in
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
//            get only thoese recipes that doesnot match with exsiting one.
            // append new recipes into the existing one.
            self.others_Recipes +=  tempRecipes
        }
        
    }
}

// MARK: Meal Planner Firebase CRUD
extension MealRecommendationViewModel {
    
    
    /// This function is performating two operation
    /// 1. its is adding meal into daily plane
    /// 2. its also adding meal into weekly plane
    /// The decision base on the type of variable.
    ///     if date is not null then add into daily meal plane
    ///     if dayOfweek is not null then add into Weekly meal plane
    func addMeal(recipe: RecipeModel, date: Date?, dayOfweek: String?, mealCategory: String, completion: @escaping (Bool, String) -> ()) {

//        make this value variable
        var recipe_var = recipe
        recipe_var.calories = "\((Float(recipe.calories) ?? 0) * convertFractionInToDecimal(fraction: portionOfMealSelected))"
        
        if date != nil {
            // add recipe into daliy plane
            let strDate = DateManager.standard.getCurrentString(from: date!)
            SwiftSpinner.show("Loading...")
            // use the same recipe id that we have save into the database

            
            database.child(mealPlannerTable).child(userID).child(mealCategory).child(strDate).child(recipe.id!).setValue(recipe_var.convertToDictionary!, withCompletionBlock: { error, ref in
                
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
            var weeklyRecipe = recipe_var
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
    
    
    /// This function is performating two function
    /// 1. First it will add this into your meal
    /// 2. then add this into you daily meal plane
    
    func addBarCodeMeal(recipe: RecipeModel, date: Date?, dayOfweek: String?, mealCategory: String, completion: @escaping (Bool, String) -> ()) {

//        insert this Food Item to the record of current user's recipe
        FirebaseDatabaseManager.shared.insertRecipe(with: recipe) { status, id in
            
            var recipeModel = RecipeModel()
            recipeModel = recipe
            recipeModel.id = id
            
//            then add this into daily or weekly meal plane
            self.addMeal(recipe: recipeModel, date: date, dayOfweek: dayOfweek, mealCategory: mealCategory, completion: completion)
        }
        
        
        
    }
    
    // this function will update the daily meal planner once a new weekly plan is added.
    func updateDailyMealPlannerWithWeeklyPlane(recipe: RecipeModel, dayOfweek: String?, mealCategory: String) {
        
        // this line will get the date for day of the week.
        let dateOfWeekDay = DateManager.standard.getDateFromWeekDay(weekDay: dayOfweek ?? "", date: UserDefaultManager.shared.getStartDateOfWeek() ?? Date())
        
        let strDate = DateManager.standard.getCurrentString(from: dateOfWeekDay)
        
        database.child(mealPlannerTable).child(userID).child(mealCategory).child(strDate).child(recipe.id!).setValue(recipe.convertToDictionary!, withCompletionBlock: { error, ref in

            guard error == nil else {
                print(error?.localizedDescription)
                return
            }
            
        })
        
    }

}

// MARK: Alamorire Extension

extension MealRecommendationViewModel {
    
    func callNetworkApi(productId: String) {

        NetworkManager.shared.URLrequest(productId: productId, methodType: .get, parametres: nil, returnType: BarCodeDataModel.self) { data, statusCode in
            
            if let product = data as? BarCodeDataModel {
                
                if product.status == 1 {

//                    Transform the online product to our local product model
                    var recipeModel = RecipeModel()
                    
                    recipeModel.img_url = product.product?.imageURL ?? ""
                    
                    if product.product?.genericNameEn != nil {
                        recipeModel.name = product.product?.genericNameEn ?? "NA"
                    }
                    
                    if product.product?.product_name != nil {
                        recipeModel.name = product.product?.product_name ?? "NA"
                    }
                    
                    
                    recipeModel.details = product.product?.ingredientsText ?? "NA"
                    recipeModel.makeTime = "Easy"
                    recipeModel.userName = UserDefaultManager.shared.userName
                    
                    recipeModel.fat = String(format: "%.3f", product.product?.nutriments?.fat100G ?? 0.0)
                    recipeModel.calories = String(format: "%.3f", product.product?.nutriments?.energy100G ?? 0)
                    recipeModel.protenis = String(format: "%.3f", product.product?.nutriments?.proteins100G ?? 0.0)
                    recipeModel.carbohydrates = String(format: "%.3f", product.product?.nutriments?.carbohydrates100G ?? 0.0)
                    
                    // this is use to navigat througout the app
                    UserDefaults.standard.set("", forKey: "productID")
                    
                        self.transformedRecipeModel = recipeModel
                        self.moveMealDetailView = true
                    
                    
                    
                } else {
                    print(product.statusVerbose ?? "")
                    self.showError(message: product.statusVerbose ?? "No Product found ")
                    
                    
                }

            }
                
        } withapiFiluer: { errorString in
            self.errorMessage = errorString
            
        }
    }
    
}
