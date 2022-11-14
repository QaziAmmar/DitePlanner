//
//  ColorExtension.swift
//  MyFavoutiteFoods
//
//  Created by Shanker Jadav on 4/4/21.
//

import Foundation
import Combine
import SwiftUI

let appColorArray = ["bgGray", "bgGreen", "bgPink", "bgPurple", "bgSky", "bgYellow"]

extension Color {
    
    static func ligh_gray() -> Color {
        Color(hex: "#d3d3d3")
    }

    public static let cdOffBlack = Color(red: 20 / 255, green: 20 / 255, blue: 20 / 255)
    public static let cdDarkGray = Color(red: 48 / 255, green: 48 / 255, blue: 48 / 255)
    
    public static let cdOffGreen = Color(red: 137 / 255, green: 240 / 255, blue: 170 / 255)
    public static let cdOffBlue = Color(red: 137 / 255, green: 207 / 255, blue: 240 / 255)
    public static let cdOffOrange = Color(red: 240 / 255, green: 170 / 255, blue: 137 / 255)
    public static let cdOffPurple = Color(red: 187 / 255, green: 137 / 255, blue: 207 / 255)
    
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


/// this function will generate the random color each time
func randomColorGenerator() -> Color {
    let randomInt = Int(arc4random()) % 6
    return Color(appColorArray[randomInt])
}




extension EditMode {
    
    var title: String {
        self == .active ? "Done" : "Edit"
    }

    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}

