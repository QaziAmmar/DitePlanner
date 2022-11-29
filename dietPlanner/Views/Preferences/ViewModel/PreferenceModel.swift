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
//    var image: String
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
//


let fruites_name_array = ["apple", "Watermelon", "Orange", "Pear", "Strawberry", "Grape", "Plum", "Mango", "Blueberry", "Papaya", "Apricot", "Mandarin", "Banana", "Grapefruit", "Lemon", "Lime", "Pineapple", "Jackfruit", "Melon", "Coconut", "Avocado", "Peach", "Kiwi", "Blackcurrant", "Blackberry", "Cherry", "Fig", "Lychee", "Nectarine", "Passionfruit", "Quince", "Raspberry", "Tangerine", "Pomegranate", "Mulberry", "Starfruit", "Guava", "Pomelo", "Cranberry", "Rock Melon", "Dragon Fruit", "Rambutan"] // 0 - 41

let vegetables_name_array = ["Cucumber", "Onion", "Red Onion", "Garlic", "Carrot", "Red Cabbage", "White Cabbage", "Radish", "Eggplant", "Mushroom", "Artichoke", "Corn", "Broccoli", "Cauliflower", "Celery", "Red Chili", "Green Chili", "Sweet Potato", "Asparagus", "Pumpkin", "Fennel", "Spring Onion", "Turnip", "Lettuce", "Zucchini", "Brussels Sprout", "Tomato", "Potato", "Pea", "Spinach", "Beetroot", "Capsicum", "Leek", "Ginger", "Squash", "Coriander", "Kale", "Taro"] // 38

let meats_name_array = ["Beef", "Chicken", "Lamb", "Veal", "Fish", "Prawns", "Pork", "Bacon", "Ham", "Kangaroo", "Duck", "Turkey", "Mussels", "Oysters", "Scallops", "Clams", "Tofu", "Mutton", "Venison"] // 19



//dislikeFoodArray = [DislikeFoodModel(name: "Peanuts", image: "peanut", isSelected: false),
//                        DislikeFoodModel(name: "Tree Nuts", image: "treenut", isSelected: false),
//                        DislikeFoodModel(name: "Dairy", image: "glass", isSelected: false),
//                        DislikeFoodModel(name: "Fish", image: "fish", isSelected: false),
//                        DislikeFoodModel(name: "ShellFish", image: "oyster", isSelected: false),
//                        DislikeFoodModel(name: "Eggs", image: "egg", isSelected: false),
//                        DislikeFoodModel(name: "Wheat", image: "wheats", isSelected: false),
//                        DislikeFoodModel(name: "Sugar", image: "sugar", isSelected: false),
//                        DislikeFoodModel(name: "Sweeteners", image: "sweet", isSelected: false),
//                        DislikeFoodModel(name: "Mustard", image: "sause", isSelected: false),
//                        DislikeFoodModel(name: "Sesame", image: "peanut", isSelected: false),
//                        DislikeFoodModel(name: "Mushrooms", image: "sesame", isSelected: false),
//                        DislikeFoodModel(name: "Soy", image: "soy", isSelected: false),
//                        DislikeFoodModel(name: "Red Meat", image: "meat", isSelected: false),
//                        DislikeFoodModel(name: "White Meat", image: "thigh", isSelected: false),
//                        DislikeFoodModel(name: "Alcohol", image: "vine", isSelected: false),
//                        DislikeFoodModel(name: "GrapeFruit", image: "fruit", isSelected: false)
//]
