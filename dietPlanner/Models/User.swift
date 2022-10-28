//
//  User.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 17/03/2022.
//

import Foundation

/// model for creation of new user
struct User: Codable {
    
    var userName: String
    var firebaseID: String
    var userEmail: String
    var password: String
    var age: String = ""
    var phone: String = ""
    var image_url: String = ""
    
    
    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case firebaseID = "firebase_id"
        case userEmail = "user_email"
        case age = "age"
        case phone = "phone"
        case image_url = "image_url"
        case password = "password"
    }

}
