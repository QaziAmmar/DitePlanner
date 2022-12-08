//
//  Constants.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 03/03/2022.
//

import Foundation


enum ImageName: String {
    
    
//    TabBar Images
    case google = "google"
    case show = "show"
    case hide = "hide"
   
    
    // dite planner icons
    case loginbg = "loginimg"
    case logupbg = "logupimg"
    case welcome = "welcome"
    case wt1 = "wt1"
    case wt2 = "wt2"
    case cross = "cross"
    case breakFast = "breakfast"
    case lunch = "lunch"
    case dinner = "dinner"
    case snacks = "snacks"
    case camera = "camera"
    
//   Button Images
//    case forwardBtn = "forward"
    case wt1Btn = "wt1btn"
    case wt2Btn = "wt2btn"
    
    // Fit Me Application
    case cook = "cook"
    case meal = "meal"
    case cart = "cart"
    
    
    // generic place holder for images
    case genricPlaceHolder = "GenricPlaceHolder"
    case forward = "chevron.forward"
    
    // category Check uncheck
    case unckeck = "unckeck"
    case check = "check"
    case checkList = "checkList"
    
    case delete = "delete"
    case dropDown = "dropDown"
    
    // meals icon
    case calories = "Calories"
    
}

enum ColorName: String {
    
    case appLiteBlack = "appLightBlack"    
    case appDarkGreen = "appDarkGreen"
    //Sign Up & Sign In Color
    case textFieldBgColor = "TFBackgroundColor"
    case TFBorderColor = "TFBorderColor"
    
    // dite planner view.
    case appGreen = "appGreen"
    case appMain = "appMain"
    case appMainLight = "appMainLight"
    case appGray = "appGray"
    case lightGreen = "lightGreen"
    case appPale = "bgclr"
    case appAqua = "btnBlue"
    case nutritionBg = "nutritionbg"
    case recipeCardBg = "cardbg"
    
    case categorybg1 = "categorybg1"
    case categorybg2 = "categorybg2"
    
}

enum RobotoCondensed: String {
    case Bold = "RobotoCondensed-Bold"
    case Light = "RobotoCondensed-Light"
    case Regular = "RobotoCondensed-Regular"
    case Heavy = "RobotoCondensed-Heavy"
}

enum Roboto: String {
    case Black = "Roboto-Black"
    case Bold = "Roboto-Bold"
    case Light = "Roboto-Light"
    case Medium = "Roboto-Medium"
    case Regular = "Roboto-Regular"
    case Thin = "Roboto-Thin"
}

enum HTTPHeaderKEYS: String {
    
    case Accept =  "Accept"
}


enum NavViews {
    
    case preferences
    case edit_profile
    case change_password
    case goals
    case logout
    
    
}

enum FireBaseTable: String {
    case recipes = "recipes"
    case dite_preferences = "dite_preferences"
    case dislike_food = "dislike_food"
    case users = "Users"
    case shoppingList = "shopping_list"
    case mealPlanner = "meal_planner"
    case weekly_meal_plan = "weekly_meal_plan"
    case start_date_of_week = "start_date_of_week"
    case goals = "goals"
}





enum FoodIcons: String {
        case peanuts = "peanut"
    case treeNuts = "treenut"
    case dairy = "glass"
    case fish = "fish"
    case shellFish = "oyster"
    case eggs = "egg"
    case wheat = "wheats"
    case sugar = "sugar"
    case sweeteners = "sweet"
    case legumes = "legumes"
    case mustard = "sause"
    case sesame = "sesame"
    case mushrooms = "mush"
    case soy = "soy"
    case redMeat = "meat"
    case whiteMeat = "thigh"
    case alcohol = "vine"
    case grapefruit = "fruit"
}

enum Heart: String {
    case heart = "heart"
    case heartFill = "heartfill"
}

enum CategoryIcons: String {
    case cow = "cow"
    case fruits = "fruits"
    case household = "household"
    case meats = "meats"
    case pantry = "pantry"
    case pie = "pie"
    
}


enum Nunito: String {
    case Black = "Nunito-Black"
    case Bold = "Nunito-Bold"
    case Light = "Nunito-Light"
    case Medium = "Nunito-Medium"
    case Regular = "Nunito-Regular"
    case Semibold = "Nunito-SemiBold"
    case ExtraBold = "Nunito-ExtraBold"
}

// Constant Variable for whole app
let SOCIAL_PASSWORD = "social_password"
let DAILY = "Daily"
let WEEKLY = "Weekly"
