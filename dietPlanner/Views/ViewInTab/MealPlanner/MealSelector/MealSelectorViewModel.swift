//
//  MealSelectorViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 25/10/2022.
//

import Foundation

class MealSelectorViewModel: ObservableObject {

    
    @Published var categories = ["Breakfast", "Lunch", "Dinner", "Snack/Other"]
    @Published var selectedCategory = 0
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false

    
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }
    

}
