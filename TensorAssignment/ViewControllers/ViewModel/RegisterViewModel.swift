//
//  RegisterViewModel.swift
//  TensorAssignment
//
//  Created by EAD on 10/10/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Firebase
import SVProgressHUD

class RegisterViewModel {
    private let databaseViewModel = DatabaseViewModel()
    private let uploadImageViewModel = UploadImageViewModel()
    
    func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }
   
    func onRegisterTapped(email: String, password: String, confirmpassword: String, username: String, bio: String, profileImg: UIImage, isImageUpload: Bool, completion: ((_ user: UserModel?, _ success: Bool?, _ error: String?) -> Void)?) {
        if Utility.isValidEmail(email),
           Utility.isValidPassword(password),
           Utility.isValidConfirmPassword(password, confirmpassword), !username.isEmpty, !bio.isEmpty, isImageUpload {
            
            self.signUp(email: email, password: password) { [weak self] error in
                SVProgressHUD.show()

                if let error = error {
                    SVProgressHUD.dismiss()
                    completion?(nil, false, "Error signing up: \(error.localizedDescription)")
                } else {
                    self?.uploadImageViewModel.uploadImage(profileImg) { [weak self] result in
                        SVProgressHUD.dismiss()
                        switch result {
                        case .success(let downloadURL):
                            let id = email.stripped
                            let user = UserModel(id: id, email: email,username: username, bio: bio, profileUrl: downloadURL.absoluteString)
                            UserDefaults.standard.set(email, forKey: "Email")
                            UserDefaults.standard.set(id, forKey: UserDefaultKeys.userId)
                            UserDefaults.standard.set(true, forKey: UserDefaultKeys.isLoggedIn)
                            UserDefaults.standard.synchronize()
                            self?.databaseViewModel.saveUser(user)
                            completion?(user, true, nil)
                            
                        case .failure(let error):
                            completion?(nil, false, "Error uploading image: \(error.localizedDescription)")
                        }
                    }
                }
            }
        } else {
            if !Utility.isValidEmail(email) {
                completion?(nil, false, ErrorMessages.invalidEmail)
            } else if !Utility.isValidPassword(password) {
                completion?(nil, false, ErrorMessages.invalidPassword)
            } else if !Utility.isValidConfirmPassword(password, confirmpassword) {
                completion?(nil, false, ErrorMessages.passwordMatch)
            } else if username.isEmpty{
                completion?(nil, false, ErrorMessages.enterUsername)
            }  else if bio.isEmpty{
                completion?(nil, false, ErrorMessages.enterBio)
            } else if !isImageUpload {
                completion?(nil, false, ErrorMessages.selectImage)
            }
        }
    }
}
