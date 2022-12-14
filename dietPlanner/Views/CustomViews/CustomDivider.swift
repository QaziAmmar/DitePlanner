//
//  CustomDivider.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 12/03/2022.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.gray.opacity(0.4))
    }
}

struct CustomDivider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
