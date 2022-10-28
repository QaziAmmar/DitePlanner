//
//  CustomPasswordField.swift
//  dietPlanner
//
//  Created by Aqsa's on 15/09/2022.
//

import SwiftUI

struct CustomPasswordField: View {
    @Binding var text: String
    @State  var isSecured: Bool
   
    var placeHolder : String
   
    var body: some View {
                  
           
       
            VStack(alignment: .leading){
               
                
                ZStack(alignment: .trailing){
                    Group{
                        if isSecured {
                            SecureField("Password", text: $text)
                        } else {
                            TextField(placeHolder, text: $text)
                        }

                    }
//                    VStack {
//                                SecureField("Enter a password", text: $text)
//                            }
                        .padding()
                        .background(
                         Rectangle()
                            
                            .foregroundColor(Color.white)
                                            
                         .opacity(0.2)
                                         
                        )
                        .overlay(
                               RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1.5)
                           )
                    Button(action: {
                        isSecured.toggle()
                    }) {
                        Image(systemName: self.isSecured ? "eye.slash" : "eye")
                            .accentColor(.gray)
                            .padding()
                    }
                }
        }
            
          
        
            
        }
}

struct CustomPasswordField_Previews: PreviewProvider {
    static var previews: some View {
        CustomPasswordField( text: .constant("dfdf"), isSecured: true, placeHolder: "Password")
    }
}
