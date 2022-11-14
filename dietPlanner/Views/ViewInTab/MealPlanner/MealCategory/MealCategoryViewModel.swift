//
//  WeeklyMealPlaneViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 25/10/2022.
//

import Foundation


class MealCategoryViewModel: ObservableObject {

    @Published var mealName = ["Breakfast", "Lunch", "Dinner", "Snacks/Others"]
    
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false

    
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }
    

}
