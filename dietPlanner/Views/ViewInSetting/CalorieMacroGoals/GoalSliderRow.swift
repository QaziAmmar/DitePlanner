//
//  GoalSliderRow.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 15/11/2022.
//

import SwiftUI
import Sliders

struct GoalSliderRow: View {
    
    var text: String
    @Binding var value: Double
    var color: Color
    
    var body: some View {
        
        HStack {
            ZStack {
                Circle()
                       .frame(width: 45)
                       .foregroundColor(color.opacity(0.5))
                Image(text)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18)
            }
         
            VStack(spacing: 5) {
                
                HStack {
                    Text(text)
                        .font(.custom(Nunito.Semibold.rawValue, size: 16))
                    
                    Spacer()
                    
                    Text(" \(Int(value * 5000))")
                        .font(.custom(Nunito.Regular.rawValue, size: 14))
                        .foregroundColor(.gray)
                }

                ValueSlider(value: $value)
                    .valueSliderStyle(
                        HorizontalValueSliderStyle(
                            track:
                                HorizontalValueTrack(
                                    view: Capsule().foregroundColor(color.opacity(0.9))
                                )
                                .background(Capsule().foregroundColor(.gray.opacity(0.2)))
                                .frame(height: 10),
                            thumb:
                                ZStack {
                                    Capsule()
                                        .fill(color.opacity(0.9))
                                        .frame(height: 15)
                                    
                                    Capsule()
                                        .fill(.white)
                                        .frame(width: 13, height: 3)
                                }
                        )
                    )
                    .frame(height: 20)
                    
            }
        }.padding()
    }
}

struct GoalSliderRow_Previews: PreviewProvider {
    static var previews: some View {
        GoalSliderRow(text: "Calories", value: .constant(0.8), color: .red)
    }
}
