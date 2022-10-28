//
//  GeneralResponseModel.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 19/03/2022.
//

import Foundation

struct GeneralResponse: Codable {
    let api_status: Int
    let status: Bool
    let message: String 
}
