//
//  PreferenceModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 26/10/2022.
//

import Foundation


struct DitePreferenceModel: Codable, Hashable, Identifiable {
    var id: String?
    var name: String
    var isSelected: Bool
    var createdAt = Date().timeIntervalSince1970
    var updatedAt = Date().timeIntervalSince1970
}

struct DislikeFoodModel: Codable, Hashable, Identifiable {
    var id: String?
    var name: String
    var image: String
    var isSelected: Bool
    var createdAt = Date().timeIntervalSince1970
    var updatedAt = Date().timeIntervalSince1970
}

// its good practice to get these array from Json
// these array will only be use only for once
var ditePreferenceArray = [DitePreferenceModel(name: "Vegan", isSelected: false),
                           DitePreferenceModel(name: "Vegetarian", isSelected: false),
                           DitePreferenceModel(name: "Diabetic", isSelected: false),
                           DitePreferenceModel(name: "Pescatarian", isSelected: false),
                           DitePreferenceModel(name: "Clean", isSelected: false),
                           DitePreferenceModel(name: "Dairy Free", isSelected: false),
                           DitePreferenceModel(name: "None", isSelected: false)]
// its good practice to get these array from Json
// these array will only be use only for once
var dislikeFoodArray = [DislikeFoodModel(name: "Peanuts", image: "peanut", isSelected: false),
                        DislikeFoodModel(name: "Tree Nuts", image: "treenut", isSelected: false),
                        DislikeFoodModel(name: "Dairy", image: "glass", isSelected: false),
                        DislikeFoodModel(name: "Fish", image: "fish", isSelected: false),
                        DislikeFoodModel(name: "ShellFish", image: "oyster", isSelected: false),
                        DislikeFoodModel(name: "Eggs", image: "egg", isSelected: false),
                        DislikeFoodModel(name: "Wheat", image: "wheats", isSelected: false),
                        DislikeFoodModel(name: "Sugar", image: "sugar", isSelected: false),
                        DislikeFoodModel(name: "Sweeteners", image: "sweet", isSelected: false),
                        DislikeFoodModel(name: "Mustard", image: "sause", isSelected: false),
                        DislikeFoodModel(name: "Sesame", image: "peanut", isSelected: false),
                        DislikeFoodModel(name: "Mushrooms", image: "sesame", isSelected: false),
                        DislikeFoodModel(name: "Soy", image: "soy", isSelected: false),
                        DislikeFoodModel(name: "Red Meat", image: "meat", isSelected: false),
                        DislikeFoodModel(name: "White Meat", image: "thigh", isSelected: false),
                        DislikeFoodModel(name: "Alcohol", image: "vine", isSelected: false),
                        DislikeFoodModel(name: "GrapeFruit", image: "fruit", isSelected: false)
]
