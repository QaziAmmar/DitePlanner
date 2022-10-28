//
//  Validators.swift
//  BattleRap
//
//  Created by Qazi Ammar Arshad on 18/03/2022.
//

import Foundation


/// this class is used to validate the different filds
final class Validator {
    
    static let shared = Validator()
    
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

