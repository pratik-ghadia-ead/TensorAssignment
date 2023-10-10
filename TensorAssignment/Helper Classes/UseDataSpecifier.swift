//
//  UseDataSpecifier.swift
//  TensorAssignment
//
//  Created by EAD on 09/10/23.
//

import UIKit

enum FormType {
    case login
    case register
}

struct Inputfield {
    var title: String = ""
    var text: String = ""
    var placeholder: String = ""
    var pickedImg: UIImage?
    var keyName: String = ""
}

class UserDataSpecifier: NSObject {
    var fType: FormType
    var allFields: [Inputfield]
    
    init(_ type: FormType) {
        fType = type
        allFields = []
        super.init()
        
        switch type {
        case .login:
            prepareLoginfield()
            break
        case .register:
            prepareRegisterfield()
            break
        default:
            break
        }
    }
    
    // MARK:- Login fields
    func prepareLoginfield(){
        var t1 = Inputfield()
        t1.title = "Email"
        t1.placeholder = "Enter email"
        t1.keyName = "email"
        allFields.append(t1)

        var t2 = Inputfield()
        t2.title = "Password"
        t2.placeholder = "Enter password"
        t2.keyName = "password"
        allFields.append(t2)
    }
    
    // MARK:- Register fields
    func prepareRegisterfield(){
        var t0 = Inputfield()
        t0.keyName = "profileImage"
        allFields.append(t0)
        
        var t1 = Inputfield()
        t1.title = "Email"
        t1.placeholder = "Enter email"
        t1.keyName = "email"
        allFields.append(t1)

        var t2 = Inputfield()
        t2.title = "Password"
        t2.placeholder = "Enter password"
        t2.keyName = "password"
        allFields.append(t2)
        
        var t3 = Inputfield()
        t3.title = "Confirm password"
        t3.placeholder = "Enter password"
        t3.keyName = "confirmPassword"
        allFields.append(t3)
        
        var t4 = Inputfield()
        t4.title = "Username"
        t4.placeholder = "Enter username"
        t4.keyName = "username"
        allFields.append(t4)
        
        var t5 = Inputfield()
        t5.title = "Bio"
        t5.placeholder = "Enter short bio"
        t5.keyName = "bio"
        allFields.append(t5)
    }
}

//MARK: - Public method(s)
extension UserDataSpecifier {
    
    func paramDictionaty() -> [String : String] {
        var dictParam = [String: String]()
        allFields.forEach { (inputField: Inputfield) in
            dictParam[inputField.keyName] = inputField.text.trimming(newLine: true)
        }
        return dictParam
    }
}

//MARK: - Character trimming
extension String {
    
    func trimming(newLine: Bool = false) -> String {
        if newLine {
            return trimmingCharacters(in: .whitespacesAndNewlines)
        }else{
             return trimmingCharacters(in: .whitespaces)
        }
    }
}
