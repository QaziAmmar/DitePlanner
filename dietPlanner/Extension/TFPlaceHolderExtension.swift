//
//  PlaceHolderExtension.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 07/03/2022.
//
/// This extension contains the code to change the color of UIText Field

import Foundation
import SwiftUI

struct PlaceHolder<T: View>: ViewModifier {
    
    var placeHolder: T
    var show: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if show { placeHolder }
            content
        }
    }
}

extension View {
    func placeHolder<T:View>(_ holder: T, show: Bool) -> some View {
        self.modifier(PlaceHolder(placeHolder:holder, show: show))
    }
}

