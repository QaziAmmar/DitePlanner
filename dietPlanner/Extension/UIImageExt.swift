//
//  UIImageExt.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 01/04/2022.
//

import Foundation
import SwiftUI


func getBase64String(from image: UIImage) -> String {
    guard let reducedImage = image.resizedTo1MB() else {
        print("Image is not compressed")
        return ""
    }
    guard let compressedImage = reducedImage.jpegData(compressionQuality: 0.0) else {
        print("image not compressed")
        return ""
    }
    
    let compressedString = compressedImage.base64EncodedString()
    return compressedString
}

extension UIImage {
    
    

    func resizedTo1MB() -> UIImage? {
        guard let imageData = self.pngData() else { return nil }
        let megaByte = 1000.0
        
        var resizingImage = self
        var imageSizeKB = Double(imageData.count) / megaByte // ! Or devide for 1024 if you need KB but not kB
        
        while imageSizeKB > megaByte { // ! Or use 1024 if you need KB but not kB
            guard let resizedImage = resizingImage.resized(withPercentage: 0.5),
                  let imageData = resizedImage.pngData() else { return nil }
            
            resizingImage = resizedImage
            imageSizeKB = Double(imageData.count) / megaByte // ! Or devide for 1024 if you need KB but not kB
        }
        
        return resizingImage
    }
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
