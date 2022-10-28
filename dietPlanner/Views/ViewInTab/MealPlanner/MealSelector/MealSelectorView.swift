//
//  MealSelectorView.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 25/10/2022.
//

import SwiftUI

struct MealSelectorView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var title: String
    @StateObject var vm =  MealSelectorViewModel()
    
    var body: some View {
        loadView()
            .alert(isPresented: $vm.showError) {
                Alert(title: Text(vm.errorMessage))
            }
            .background(Color(ColorName.appMain.rawValue))
    }
}

//MARK: UIView Extension

extension MealSelectorView {
    func loadView() -> some View {
        VStack {
            NavBar(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, title: title)
            
            Spacer()
        }
        
    
    }
}



struct MealSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        MealSelectorView(title: "Breakfast")
    }
}
