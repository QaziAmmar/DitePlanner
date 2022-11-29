//
//  PreferenceViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 26/10/2022.
//
import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation

class PreferenceViewModel: ObservableObject {
    
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
//    @Published var ditePreference = DitePreferenceModel()
    
    @Published var dite_preferences = [DitePreferenceModel]()
    @Published var dislike_foods = [DislikeFoodModel]()
    
    
    // Firebase Variable
    let userID = UserDefaultManager.shared.userId
    private let database = Database.database().reference()
    
    let disklike_table = FireBaseTable.dislike_food.rawValue
    let dite_table = FireBaseTable.dite_preferences.rawValue
}

// MARK: Custom Function Extension
extension PreferenceViewModel {
    
    // show error
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }
}


// MARK: Update food preferences and likes.
extension PreferenceViewModel {
    
    func getDitePreferenceListFirebase() {

        database.child(dite_table).child(userID).observe(.value) { snapshot in
            // 5
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            // 6
            self.dite_preferences = children.compactMap { snapshot in
                // 7
                do {
                    var dite =  try snapshot.data(as: DitePreferenceModel.self)
                    dite.id = snapshot.ref.key
                    return dite
                } catch {
                    print(error)
                    return DitePreferenceModel(name: "Fail in Parsing", isSelected: false)
                }
            }
        }
    }
    
    func getDislikeFoodListFirebase() {

        database.child(disklike_table).child(userID).observe(.value) { snapshot in
            // 5
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            // 6
            self.dislike_foods = children.compactMap { snapshot in
                // 7
                do {
                    var dislike =  try snapshot.data(as: DislikeFoodModel.self)
                    dislike.id = snapshot.ref.key
                    return dislike
                } catch {
                    print(error)
                    return DislikeFoodModel(name: "Fail in Parsing", isSelected: false)
                }
            }
        }

    }

    // update dislike food
    func updateDislikeFood(dislikeFood: DislikeFoodModel) {
        if let id = dislikeFood.id {
            database.child(disklike_table).child(userID).child(id).updateChildValues(dislikeFood.convertToDictionary!)
        }
    }
    
    // update
    func updateDitePreference(with dite: DitePreferenceModel) {
        if let id = dite.id {
            database.child(dite_table).child(userID).child(id).updateChildValues(dite.convertToDictionary!)
        }
    }
    
}
