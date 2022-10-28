//
//  UserDefalutsObjects.swift
//  dietPlanner
//
//  Created by Aqsa's on 07/10/2022.
//

import SwiftUI

struct UserDefalutsObjects: View {
    @State var text: String = ""
    @State var id: String = ""
    var body: some View {
        VStack {
            HStack {
                Text("Name")
                TextField("Enter the name", text: $text)
                
            }
            HStack {
                Text("ID")
                TextField("Enter the ID", text: $id)
                
            }
            SaveButton()
            RetrieveButton()
        }
    }
}

extension UserDefalutsObjects {
    func SaveButton() -> some View {
        Button {
            SaveData()
        }
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 46)
                        .foregroundColor(Color("btnBlue"))
                Text("Save Data")
                        .font(.custom("Nunito-Bold", size: 20))
                    .foregroundColor(.white)
                }
            }
    }
    
    func RetrieveButton() -> some View {
        Button {
            Retrieve()
        }
            label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 46)
                        .foregroundColor(Color("btnBlue"))
                Text("Retrieve Data")
                        .font(.custom("Nunito-Bold", size: 20))
                    .foregroundColor(.white)
                }
            }
    }
    
    
    func SaveData() {
        let object = Details()
        object.ids = id
        object.names = text
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(object), forKey: "Details")
        
        print("Data has been Saved")

    }
    
    func Retrieve() {
        var retrieveObject = Details()
        if let userData = UserDefaults.standard.value(forKey: "Details") as? Data {
            let retrieveObject = try? PropertyListDecoder().decode(Details.self, from: userData)
            print("Name is \(retrieveObject?.names ?? "")")
            print("ID is \(retrieveObject?.ids ?? "")")
        }

    }
    
}


struct UserDefalutsObjects_Previews: PreviewProvider {
    static var previews: some View {
        UserDefalutsObjects()
    }
}
