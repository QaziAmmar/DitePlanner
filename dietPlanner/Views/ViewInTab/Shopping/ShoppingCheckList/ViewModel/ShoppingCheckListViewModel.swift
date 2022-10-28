//
//  ShoppingCheckListViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 28/10/2022.
//

import Foundation
import UIKit
import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift


class ShoppingCheckListViewModel: ObservableObject {
    
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var shoppingItemModel = ShoppingItemModel()
    @Published var shopping_items_array = [ShoppingItemModel]()
    @Published var noItemFound = false

    var categoryName: String = ""
    
    // Firebase Variable
    let userID = UserDefaultManager.shared.userId
    private let database = Database.database().reference()
    let tableName = FireBaseTable.shoppingList.rawValue
    
    
}

// MARK: Custom Function Extension
extension ShoppingCheckListViewModel {

    // show error
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }

    // check text field validation
    private func validationCheck() -> Bool {

        if  shoppingItemModel.name.isEmpty {
            showError(message: "Please enter the nmae of item")
            return false
        }
        return true

    }

}



// MARK: FireBase CRUD Extesion
extension ShoppingCheckListViewModel {

    // create recipe against each user
    func addItem(completion: @escaping (Bool, String) -> ()) {

        if !validationCheck() {
            return
        }

        database.child(tableName).child(userID).child(categoryName).childByAutoId().setValue(shoppingItemModel.convertToDictionary!, withCompletionBlock: { error, ref in
            
            guard error == nil else {
                completion(false, "failed to write to database")
                return
            }
            completion(true, ref.key ?? "no key found")
        })
        
    }

    func getshoppingList() {
        
        database.child(tableName).child(userID).child(categoryName).observe(.value) { snapshot in
            // 5
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            if children.count == 0 {
                self.noItemFound = true
            }
            // 6
            self.shopping_items_array = children.compactMap { snapshot in
                // 7
                do {
                    let item =  try snapshot.data(as: ShoppingItemModel.self)
                    item.id = snapshot.ref.key
                    return item
                } catch {
                    print(error)
                    return ShoppingItemModel()
                }

            }
        }
    }


    func updateShoppingItem(shoppingItem: ShoppingItemModel) {
        if let id = shoppingItem.id {
            database.child(tableName).child(userID).child(categoryName).child(id).updateChildValues(shoppingItem.convertToDictionary!)
        }
    }
}
