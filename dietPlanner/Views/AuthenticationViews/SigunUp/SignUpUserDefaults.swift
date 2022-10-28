//
//  SignUpUserDefaults.swift
//  dietPlanner
//
//  Created by Aqsa's on 12/10/2022.
//

import Foundation

class ToSave: Codable {
    var userName: String?
    var userEmail: String?
    var userPassword: String?
    
    init() {
        userName = ""
        userEmail = ""
        userPassword = ""
    }
}
