//
//  extensionView.swift
//  HTPlanner
//
//  Created by Aqsa's on 05/08/2022.
//

import Foundation
import SwiftUI
extension View {
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func onDelete(perform action: @escaping () -> Void) -> some View {
        self.modifier(Delete(action: action))
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
