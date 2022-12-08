//
//  CalorieAlertView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 30/11/2022.
//

import SwiftUI

struct CalorieAlertView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            HStack {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "multiply")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(ColorName.appGreen.rawValue))
                }
                Spacer()
                Text("Alert")
                    .foregroundColor(.red)
                    .font(.system(size: 20, weight: .bold))
                    .offset(x: -16)
                Spacer()
            }.padding([.leading, .top, .trailing])
            
            Divider()
            
           
            VStack(alignment: .leading, spacing: 10) {
                Text("Based on your total calories values, you are not likely to meet your body's basic nutrient")
                    .foregroundColor(.red)
                    .font(.system(size: 16, weight: .semibold))
                
                Text("For safe weight loss, the National Institutes of Health recommends no less than 1000 - 1200 calories for women and 1200 - 1500 calories for men.")
                    .font(.system(size: 16))
                
                Text("Completing your diary with fewer than the minimum calories noted above will not generate a news feed post for that day, or show a five-week weight projection.")
                    .font(.system(size: 16))
                
                Text("Even during weight loss, it's important to meet your body's basic nutrient and energy needs. Over time, not eating enough can lead to nutrient deficiencies, unpleasant side effects & other serious health problems.")
                    .font(.system(size: 16))
            }.padding([.trailing, .leading, .top])
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text("To safely meet your goals:")
                    .font(.system(size: 18))
                
                textWithBullot(text: "Focus on consuming nutrient-rich foods and beverages")
                textWithBullot(text: "Check your progress in MyFitnessPal throughout the day")
                textWithBullot(text: "Add nutritious snacks between meals as needed")
            }.padding()
            
            Spacer()
            
        }
        
    }
    
    func textWithBullot(text: String) -> some View {
        HStack {
            Circle()
                .frame(width: 5)
            Text(text)
                .font(.system(size: 16))
            
        }
    }
    
}

struct CalorieAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieAlertView()
    }
}
