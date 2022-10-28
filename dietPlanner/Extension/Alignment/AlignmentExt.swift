//
//  AlignmentExt.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 12/03/2022.
//

import SwiftUI

extension HorizontalAlignment {
   private enum MyLeadingAlignment: AlignmentID {
      static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
         return dimensions[HorizontalAlignment.leading]
      }
   }
   static let myLeading = HorizontalAlignment(MyLeadingAlignment.self)
}
