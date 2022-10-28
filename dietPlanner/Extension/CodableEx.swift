//
//  CodableEx.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 26/10/2022.
//

import Foundation

extension Encodable {
    var convertToDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}
