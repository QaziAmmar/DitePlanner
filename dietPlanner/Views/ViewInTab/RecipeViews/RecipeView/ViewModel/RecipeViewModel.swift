//
//  RecipeViewModel.swift
//  dietPlanner
//
//  Created by Qazi Ammar Arshad on 25/10/2022.
//
import UIKit
import Combine
import FirebaseDatabase
import FirebaseDatabaseSwift
import Foundation


class RecipeViewModel: ObservableObject {


    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var recipeModel = RecipeModel()
    @Published var recipeType = ""
    @Published var recipeImage: UIImage?

    @Published var recipesArray = [RecipeModel]()


    // Firebase Variable
    let userID = UserDefaultManager.shared.userId
    let userName = UserDefaultManager.shared.userName
    private let database = Database.database().reference()
    let tableName = FireBaseTable.recipes.rawValue
}

// MARK: Custom Function Extension
extension RecipeViewModel {

    // show error
    func showError(message: String)  {
        errorMessage = message
        showError = true
    }

    // check text field validation
    private func validationCheck() -> Bool {

        
        if recipeModel.details.isEmpty || recipeModel.name.isEmpty || recipeModel.type.isEmpty {
            showError(message: "Please fill all the fields")
            return false
        }
        // check either recipe image is selected
        if recipeImage == nil {
            showError(message: "Please select receipe image")
            return false
        }
        
        if ((recipeModel.fat.isEmpty) || (recipeModel.calories.isEmpty) || (recipeModel.protenis.isEmpty) || (recipeModel.carbohydrates.isEmpty) ) {
            showError(message: "Please fill food Nutrients")
            return false
        }

        return true

    }

}



// MARK: FireBase CRUD Extesion
extension RecipeViewModel {

    // create recipe against each user
    func createRecipe(complection: @escaping (Bool, String) -> ()) {

        if !validationCheck() {
            return
        }

        // convert the image into base64
        guard let convertedImg = recipeImage!.resizedTo1MB()?.jpegData(compressionQuality : 0.1) else {
            print("image not converted or found")
            return
        }


        // first upload the image
        StorageManager().uploadProfilePicture(with: convertedImg, table: .recipes, completion: { status, path in

            switch status {

            case true:
                // adding some meta data with recipe model
                self.recipeModel.img_url = path
                self.recipeModel.userName = self.userName
                // upload the data
                FirebaseDatabaseManager.shared.insertRecipe(with: self.recipeModel) { status, id in
                    self.recipeModel = RecipeModel()
                    complection(true, "recipe uploaded successfully")
                }

            case false:
                // this path will contains the error
                print(path)
                complection(false, path)
            }

            // replace the existing model with new model

        })
    }

    func getRecipeList() {
        database.child(tableName).child(userID).observe(.value) { snapshot in
            // 5
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            // 6
            self.recipesArray = children.compactMap { snapshot in
                // 7
                do {
                    var recipe =  try snapshot.data(as: RecipeModel.self)
                    recipe.id = snapshot.ref.key
                    return recipe
                } catch {
                    print(error)
                    return RecipeModel()
                }

            }
        }
    }


    func likeRecipe(recipe: RecipeModel) {
        if let id = recipe.id {
            database.child(tableName).child(userID).child(id).updateChildValues(recipe.convertToDictionary!)
        }
    }
}

