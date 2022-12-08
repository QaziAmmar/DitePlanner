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
    @Published var all_shopping_items: [String: [ShoppingItemModel]] = [:]
    @Published var noItemFound = false

    var categoryName: String = ""
    
    var categoriesName = ["Bakery","Fruits & Vagetables", "Meat & poultry", "Dairy & Eggs", "Pantry", "Household"]
    
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
    
    func getAllShoppingItemListName() -> [String] {
        
        var nameList = [String]()
        for (name, _) in all_shopping_items {
            let items = all_shopping_items[name] ?? []
            if items.count != 0 {
                nameList.append("-> " + name)
                nameList.append(contentsOf: items.map{$0.name})
            }
            
        }
        return nameList
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
            // re-init the variable because when we again press the add button its agian shows the previous entry
            self.shoppingItemModel = ShoppingItemModel()
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
    
    
    /// This function will get the list of all shopping categoy
    func getAllshoppingList() {
        
        for category in categoriesName {
        
            database.child(tableName).child(userID).child(category).observe(.value) { snapshot in
                // 5
                guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                    return
                }
                if children.count == 0 {
                    self.noItemFound = true
                }
                // 6
                self.all_shopping_items[category] = children.compactMap { snapshot in
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
        
        
    }


    func updateShoppingItem(shoppingItem: ShoppingItemModel, categoryName: String) {
        if let id = shoppingItem.id {
            database.child(tableName).child(userID).child(categoryName).child(id).updateChildValues(shoppingItem.convertToDictionary!)
        }
    }
    
    
    func deleteShppingItem(shoppingItem: ShoppingItemModel, categoryName: String) {
        if let id = shoppingItem.id {
            database.child(tableName).child(userID).child(categoryName).child(id).removeValue()
        }
    }
}
