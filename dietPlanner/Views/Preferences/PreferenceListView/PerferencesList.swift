//
//  PerferencesListView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 26/10/2022.
//

import SwiftUI

struct PerferencesList: View {

    @ObservedObject var vm: PreferenceViewModel
    
    var body: some View {
        loadView()
    }
}


extension PerferencesList {
    
    func loadView() -> some View {
        VStack{
            ScrollView{
                ForEach($vm.dite_preferences, id: \.self) { dite in
                    DietPreferenceRow(dite: dite, vm: vm)
                }
            }.padding()
        }
    }
}
    
    struct PerferencesListView_Previews: PreviewProvider {
        static var previews: some View {
            PerferencesList(vm: PreferenceViewModel())
        }
    }
