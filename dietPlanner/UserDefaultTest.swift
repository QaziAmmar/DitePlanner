//
//  UserDefaultTest.swift
//  dietPlanner
//
//  Created by Aqsa's on 07/10/2022.
//

import SwiftUI
struct user {
    
    var name: String
    var id: String
    var email: String
    
}


struct UserDefaultTest: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    var body: some View {
        VStack {
            Button("Tap count: \(tapCount)") {
                tapCount += 1
            }
          
            
        }
    }
}

struct UserDefaultTest_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultTest()
    }
}
