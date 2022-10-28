//
//  DietRecommendationViewModel.swift
//  dietPlanner
//
//  Created by Aqsa's on 21/09/2022.
//

import Foundation
class DietRecommendationViewModel: ObservableObject {
    var RecommendationItem = [
    DietRecommendationModel( image: "bun", name: "Honey Pancake", difficulty: "Easy", time: "30mins", calories: "130kCal", bgClr: "categorybg1", btnBg: "categorybgdark1", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"),
    DietRecommendationModel( image: "bun", name: "Lemon Pancake", difficulty: "Medium", time: "30mins", calories: "200kCal", bgClr: "categorybg2", btnBg: "categorybgdark2", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"),
    DietRecommendationModel( image: "bun", name: "Honey Pancake", difficulty: "Easy", time: "30mins", calories: "130kCal", bgClr: "categorybg1", btnBg: "categorybgdark1", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"),
    DietRecommendationModel( image: "bun", name: "Honey Pancake", difficulty: "Easy", time: "30mins", calories: "130kCal", bgClr: "categorybg1", btnBg: "categorybgdark1", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"),
    DietRecommendationModel( image: "bun", name: "Honey Pancake", difficulty: "Easy", time: "30mins", calories: "130kCal", bgClr: "categorybg1", btnBg: "categorybgdark1", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"),
    ]
    
}

var PopularItem = [
PopularItemModel( image: "pancake2", name: "BlueBerry Pancake", difficulty: "Medium", time: "30mins", calories: "400kCal"),
PopularItemModel( image: "pancake2", name: "BlueBerry Pancake", difficulty: "Medium", time: "30mins", calories: "400kCal"),

]

var BreakFastItem = [
    BreakFastModel( itemImage: "bigpancake", name: "Blueberry Pancake", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"),
    BreakFastModel( itemImage: "bigpancake", name: "Blueberry Pancake", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"),
    BreakFastModel( itemImage: "bigpancake", name: "Blueberry Pancake", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"),BreakFastModel( itemImage: "bigpancake", name: "Blueberry Pancake", chef: "Arash Gupta Bhansodi", icon: "cals", cals: "180kCal", description: "djlkajfkljdslfkjsdlkfjalkjflkasdjfkdlsjfkljdfklajsfkljdsfkljsdlkfjslkf"),
]

class BFMainModelView: ObservableObject {



}

var MainItem = [
BFMainModel( image: "bf", name: "Oranges", cals: 300),
BFMainModel( image: "bf", name: "Oranges", cals: 300),
BFMainModel( image: "bf", name: "Oranges", cals: 300),
BFMainModel( image: "bf", name: "Oranges", cals: 300),

]
