//
//  ChangePreference.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 26/10/2022.
//

import SwiftUI

struct ChangePreferenceView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @StateObject var vm = PreferenceViewModel()
    
    var body: some View {
        loadView()
            .onAppear {
                vm.getDitePreferenceListFirebase()
                vm.getDislikeFoodListFirebase()
            }

        
    }
}

extension ChangePreferenceView {

    func loadView() -> some View {
        VStack {
            
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, title: "Preferences")
            
            ScrollView {
                VStack {
                    if vm.dislike_foods.isEmpty && vm.dite_preferences.isEmpty {
                        Text("Loading...")
                        Spacer()
                    }
                    PerferencesList(vm: vm)
                    
                    if !(vm.dislike_foods.isEmpty) {
                        Text("Dislike Food")
                            .font(Font.custom(Nunito.Bold.rawValue, size: 22))
                            .foregroundColor(Color(ColorName.appGreen.rawValue))
                    }
                    
                    DislikeFoodList(vm: vm)
                }
            }
        }
    }
    
}



struct ChangePreference_Previews: PreviewProvider {
    static var previews: some View {
        ChangePreferenceView()
    }
}
