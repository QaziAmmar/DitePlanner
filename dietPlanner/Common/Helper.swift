//
//  Helper.swift
//  Unified
//
//  Created by Qazi Ammar Arshad on 29/08/2022.
//

import Foundation

final class Helper {
    static let shared = Helper()
    private init() {}

    func printDebug(_ data: Any) {

    #if DEBUG
            print(data)
    #endif

    }

    func getImageURL()-> String{
//        UnifiedUrl.SCHEME + "://" + UnifiedUrl.BASEURL + UnifiedUrl.STORAGE
        return ""
    }

    
    
    func getParamsFromCodable<T:Codable>(object:T) -> [String : Any]? {

        var param  : [String : Any] = [:]

        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(object){
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)

            if let json = jsonString {
                param =  Helper.shared.convertJsonToDictionary(text: json) ?? [:]
            }

        }

        return param
    }
    func convertJsonToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}
