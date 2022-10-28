//
//  FoodDislikesViewModel.swift
//  dietPlanner
//
//  Created by Aqsa's on 10/10/2022.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift

class FoodDislikesViewModel: ObservableObject {
    
    @Published var moveToNext = false
    @Published var firebaseId: String = ""
    
    @Published var selectedItems: [String] = []
    private let ref = Database.database().reference()
    
    
    func pushDislikes(value: [String], firebaseId: String) {
        
                
        
                for dislike in value{
                    ref.child("Users").child(firebaseId).child("Dislikes").childByAutoId().setValue(
                         dislike
                    )
                }
        
               
    }
    
}
