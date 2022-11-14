//
//  SettingRow.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 10/11/2022.
//

import SwiftUI

struct SettingRow: View {
    
    var setting: SettingModel
    var onTap: (SettingType) -> ()
    
    
    var body: some View {
        HStack {
            
            Image(setting.image)
                .resizable()
                .scaledToFit()
                .frame(width: 35)
                .clipShape(Circle())
                .padding(.horizontal, 5)
            
            VStack(alignment: .leading) {
                Text(setting.title)
                    .font(.custom(Nunito.Regular.rawValue, size: 15))
                
                Text(setting.subTitle)
                    .font(.custom(Nunito.Regular.rawValue, size: 11))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: ImageName.forward.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 8)
            
        }.onTapGesture {
            onTap(setting.type)
        }
    }
}

struct SettingRow_Previews: PreviewProvider {
    static var previews: some View {
        SettingRow(setting: SettingModel(title: "Delete Account", subTitle: "We are really sorry to hear that.", image: "deleteAccount", type: .deleteAccount), onTap: { type in
            print(type)
        })
    }
}
