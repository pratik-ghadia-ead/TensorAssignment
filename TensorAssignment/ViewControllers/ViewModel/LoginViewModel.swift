//
//  LoginViewModel.swift
//  TensorAssignment
//
//  Created by EAD on 09/10/23.
//

import Foundation
import FirebaseAuth

class LoginViewModel {

    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }
    
    func onLoginTapped(email: String, password: String, completion: ((_ user: UserModel?, _ success: Bool?, _ error: String?) -> Void)?) {
        if Utility.isValidEmail(email), Utility.isValidPassword(password) {
            self.signIn(email: email, password: password) { [weak self] error in
                if let error = error {
                    completion?(nil, false, "Error signing in: \(error.localizedDescription)")
                } else {
                    let databaseViewModel = DatabaseViewModel()
                    let handle = Auth.auth().addStateDidChangeListener { auth, user in
                        UserDefaults.standard.set(email, forKey: "Email")

                        let id = email.stripped
                        UserDefaults.standard.set(id, forKey: UserDefaultKeys.userId)
                        UserDefaults.standard.set(true, forKey: UserDefaultKeys.isLoggedIn)
                        UserDefaults.standard.synchronize()
                        
                        databaseViewModel.fetchDataFromDatabase(withID: id) { user in
                            completion?(user, true, nil)
                        }
                    }

                }
            }
        } else {
            if !Utility.isValidEmail(email) {
                completion?(nil, false, ErrorMessages.invalidEmail)
            } else if !Utility.isValidPassword(password) {
                completion?(nil, false, ErrorMessages.invalidPassword)
            }
        }
    }
}
