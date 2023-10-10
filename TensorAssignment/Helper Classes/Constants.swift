//
//  Constants.swift
//  TensorAssignment
//
//  Created by EAD on 10/10/23.
//

import UIKit

struct Constant {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let weatherApiKey = "659de6fd3d6cb052384e3e7df4935166"
    static let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather"
}

struct UserDefaultKeys {
    static let isLoggedIn = "isUserLoggedIn"
    static let userId = "userId"
}

struct ErrorMessages {
    
    static let invalidEmail = "Invalid email address"
    static let invalidPassword = "Invalid password. Password must be at least 8 characters."
    static let passwordMatch = "Passwords do not match."
    static let enterUsername = "Please enter username"
    static let enterBio = "Please enter Bio"
    static let selectImage = "Please select image"
    
}
