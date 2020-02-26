//
//  Utilities.swift
//  customauth
//
//  Created by Christopher Ching on 2019-05-09.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        //let bottomLine = CALayer()
        
        //bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        // Corner style
        textfield.layer.cornerRadius = 20.0
        textfield.layer.borderWidth = 0.7
        textfield.layer.borderColor = UIColor.systemGray.cgColor
        textfield.clipsToBounds = true
        
        textfield.tintColor = UIColor.init(red: 74/255, green: 0/255, blue: 130/255, alpha: 1)
        
        //bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        // Remove border on text field
        //textfield.borderStyle = .none
        
        // Add the line to the text field
        //textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.init(red: 74/255, green: 0/255, blue: 130/255, alpha: 1)
        button.layer.cornerRadius = 20.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 20.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String?) -> Bool {
        
        guard password != nil else { return false }
           // at least one uppercase,
           // at least one digit
           // at least one lowercase
           // 8 characters total
           let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
           return passwordTest.evaluate(with: password)
    }
    
    
}
