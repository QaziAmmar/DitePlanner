//
//  ActivityShare.swift
//  HTPlanner
//
//  Created by Qazi Ammar Arshad on 16/08/2022.
//

import Foundation

import UIKit
import SwiftUI

/// MARK: This class is use to show the share intent feature on social media icon
struct ActivityViewController: UIViewControllerRepresentable {
    
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
    
}
