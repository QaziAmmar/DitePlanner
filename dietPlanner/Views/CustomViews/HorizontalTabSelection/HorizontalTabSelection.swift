//
//  HorizontalTabSelection.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 24/10/2022.
//

import SwiftUI

struct HorizontalTabSelection: View {

    var categores: [String]
    @Binding var selectedIndex: Int
    @Namespace var namespace
    var body: some View {
        loadView()
    }
}

// MARK: UIView extension
extension HorizontalTabSelection {


    func loadView() -> some View {
//        ScrollView(showsIndicators: false) {
            HStack {
                    ForEach(categores, id: \.self) { category in
                        
                        VStack(alignment: .center, spacing: 5) {
                            Text(category)
                                .foregroundColor(selectedIndex == categores.firstIndex(of: category) ? Color(ColorName.appGreen.rawValue) : .black)
                                .font(Font.custom(Nunito.Medium.rawValue, size: 14))
                                .animation(.spring(), value: self.selectedIndex)

                                RoundedRectangle(cornerRadius: 2)
                                    .frame(height: 3)
                                    .cornerRadius(3, corners: [.topLeft, .topRight])
                                    .foregroundColor(selectedIndex == categores.firstIndex(of: category) ? Color(ColorName.appGreen.rawValue) : .clear)
                                    .animation(.spring(), value: self.selectedIndex)

                        }.onTapGesture {
                            selectedIndex = categores.firstIndex(of: category) ?? 0
                        }
                        
                    }
            }
            .padding(.vertical)
//        }
    }
}

struct HorizontalTabSelection_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalTabSelection(categores: ["Dinner", "Snack-Other", "Lunch", "Breakfast"], selectedIndex: .constant(2))
    }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        
        Button {
            self.currentTab = tab
        } label: {
            VStack {
                Spacer()
                Text(tabBarItemName)
                if currentTab == tab {
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline", in: namespace,  properties: .frame)
                    
                } else {
                    Color.clear.frame(height: 2)
                }
            }
            .animation(.spring(), value: self.currentTab)
        }
        
    }
}
