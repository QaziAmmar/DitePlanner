//
//  ChosePreferenceView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 26/10/2022.
//

import SwiftUI

struct ChosePreferenceView: View {
    
    
    @StateObject var vm = PreferenceViewModel()
    
    
    var body: some View {
        loadView()
            .background(Color(ColorName.appMain.rawValue))
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
            .onAppear {
                vm.getDitePreferenceListFirebase()
                vm.getDislikeFoodListFirebase()
            }
    }
}


// MARK: View Extension
extension ChosePreferenceView {
    
    func loadView() -> some View {
        VStack {
            Text("Diet Preferences")
                .font(Font.custom(Nunito.Bold.rawValue, size: 22))
                .foregroundColor(Color(ColorName.appGreen.rawValue))

            if vm.dite_preferences.isEmpty {
                Text("Loading ..")
            } else {
                PerferencesList(vm: vm)
            }

            Spacer()
            
            
            NavigationLink {
                HideNavbarOf(view: ChoseDislikeFood(vm: vm))
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 50)
                        .foregroundColor(Color(ColorName.appGreen.rawValue))
                    Text("Next")
                        .foregroundColor(.white)
                        .font(Font.custom(Nunito.Bold.rawValue, size: 20))
                }
            }
            
            
        }.padding()
    }
}


struct ChosePreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ChosePreferenceView()
    }
}
