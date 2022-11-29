// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct BarCodeDataModel: Codable {
    let code: String?
    let product: Product?
    let status: Int?
    let statusVerbose: String?

    enum CodingKeys: String, CodingKey {
        case code, product, status
        case statusVerbose = "status_verbose"
    }
}

// MARK: - Product
struct Product: Codable {
    
    let  genericNameEn: String?
    let imageURL: String?
    let ingredientsText: String?
    let nutriments: Nutriments?
    let product_name: String?
    enum CodingKeys: String, CodingKey {
       
        case ingredientsText = "ingredients_text"
        case genericNameEn = "generic_name_en"
        case imageURL = "image_url"
        case nutriments
        case product_name

    }
}



// MARK: - Nutriments
struct Nutriments: Codable {
    
//
    let carbohydrates100G: Double?
    let energy100G: Int?
    let fat100G: Double?
    let proteins100G: Double?
   

    enum CodingKeys: String, CodingKey {

        case carbohydrates100G = "carbohydrates_100g"
        case energy100G = "energy_100g"
        case fat100G = "fat_100g"
        case proteins100G = "proteins_100g"
       
    }
}
