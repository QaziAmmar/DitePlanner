//
//  DietRecommendationModel.swift
//  dietPlanner
//
//  Created by Aqsa's on 21/09/2022.
//

import Foundation
import UIKit


struct DietRecommendationModel: Identifiable {
    var id = UUID().uuidString
    
    var image : String
    var name : String
    var difficulty : String
    var time : String
    var calories : String
    var bgClr : String
    var btnBg : String
    var chef : String
    var icon : String
    var cals : String
    var description : String
    
}


struct PopularItemModel: Identifiable {
    var id = UUID().uuidString
    var image = ""
    var name = ""
    var difficulty = ""
    var time = ""
    var calories = ""
}


struct BreakFastModel: Identifiable {
    var id = UUID().uuidString
    var itemImage = ""
    var name = ""
    var chef = ""
    var icon = ""
    var cals = ""
    var  description = ""
    
}


struct BFMainModel: Identifiable {
    var id = UUID().uuidString
    var image : String
    var name : String
    var cals: Int
}
