//
//  DietPreferenceRow.swift
//  dietPlanner
//
//  Created by Aqsa's on 16/09/2022.
//

import SwiftUI

struct DietPreferenceRow: View {
    
    @Binding var dite: DitePreferenceModel
    @ObservedObject var vm: PreferenceViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(dite.isSelected ? Color(ColorName.appAqua.rawValue) : .gray, lineWidth: 1)
              .frame(height: 46)
              .background(.white)
            
            Text(dite.name)
                .foregroundColor(dite.isSelected ? Color(ColorName.appAqua.rawValue) : .gray)
                .font(.custom("Nunito-Light", size: 16))
                .padding()
        }.onTapGesture {
            dite.isSelected = !dite.isSelected
            vm.updateDitePreference(with: dite)
        }
    }
}

struct DietPreferenceRow_Previews: PreviewProvider {
    static var previews: some View {
        DietPreferenceRow(dite: .constant(DitePreferenceModel(name: "Vageterian", isSelected: true)), vm: PreferenceViewModel())
    }
}
