//
//  MealPlannerViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 25/10/2022.
//

import Foundation


import Foundation
import FirebaseAuth
import SwiftSpinner
import FirebaseDatabase

class MealPlannerViewModel: ObservableObject {

    
    @Published var categories = ["Breakfast", "Lunch", "Dinner", "Snack/Other"]
    @Published var selectedCategory = 0
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false

    
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }
    

}
