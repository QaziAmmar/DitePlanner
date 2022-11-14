//
//  RecipeModel.swift
//  dietPlanner
//
//  Created by Aqsa's on 23/09/2022.
//

import Foundation
import SwiftUI


struct RecipeModel: Identifiable, Codable, Hashable {
    var id: String?
    var isLiked: Bool = false
    var img_url: String = ""
    var name: String = ""
    var details: String = ""
    var make_difficulity = ""
    var makeTime = ""
    
    var userName = ""
    
    var fat: String = ""
    var calories: String = ""
    var protenis: String = ""
    var carbohydrates: String = ""
    
    var created_at = Date().timeIntervalSince1970
    var updated_at = Date().timeIntervalSince1970
    
    var isPartOfDaliyPlan = true
    
    var totalCalories: Int {
        return (Int(fat) ?? 0) + (Int(calories) ?? 0) + (Int(protenis) ?? 0) + (Int(carbohydrates) ?? 0)
    }

}




