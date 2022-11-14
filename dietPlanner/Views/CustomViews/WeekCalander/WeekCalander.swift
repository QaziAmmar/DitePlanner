//
//  WeekCalander.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 14/11/2022.
//

import SwiftUI

struct WeekCalander: View {
    
    
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @Binding var day: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Repeat On")
                .font(.custom(Nunito.Regular.rawValue, size: 14))
                .foregroundColor(.gray.opacity(0.7))
            
                HStack {
                    Spacer()
                    ForEach(daysOfWeek.indices) { index in
                        
                        ZStack {
                            Circle()
                                .frame(width: 40)
                                .foregroundColor(day == daysOfWeek[index] ? Color(ColorName.appGreen.rawValue) : .gray.opacity(0.5))
                                .animation(.easeInOut, value: day)
                            Text(String(daysOfWeek[index].first!))
                                .font(.custom(Nunito.Bold.rawValue, size: 16))
                                .foregroundColor(.white)
                        }.onTapGesture {
                             day = daysOfWeek[index]
                        }
                    }
                    Spacer()
                }
        }
    }
}

struct WeekCalander_Previews: PreviewProvider {
    static var previews: some View {
        WeekCalander(day: .constant("Mon"))
        
    }
}
