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
    var created_at = Date().timeIntervalSince1970
    var updated_at = Date().timeIntervalSince1970

}




