//
//  PickerTester.swift
//  dietPlanner
//
//  Created by Aqsa's on 28/09/2022.
//

import SwiftUI

struct PickerTester: View {
   
    @State var numberOfPeople = 2

    var body: some View {
       
                
                   

                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(0 ..< 100) {
                                Text("\($0) people")
                            }
                        }
                    

                
            
    }
}

struct PickerTester_Previews: PreviewProvider {
    static var previews: some View {
        PickerTester()
    }
}
