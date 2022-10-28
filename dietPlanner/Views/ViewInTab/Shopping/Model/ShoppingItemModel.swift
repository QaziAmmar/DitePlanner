//
//  ShoppingItemModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 28/10/2022.
//

import Foundation

class ShoppingItemModel: Codable, Identifiable {
    var id: String?
    var isChecked: Bool = false
    var name: String = ""
    var created_at = Date().timeIntervalSince1970
    var updated_at = Date().timeIntervalSince1970
    
}
