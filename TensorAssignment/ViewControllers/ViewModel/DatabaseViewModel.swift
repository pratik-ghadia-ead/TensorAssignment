//
//  DatabaseViewModel.swift
//  TensorAssignment
//
//  Created by EAD on 09/10/23.
//

import Foundation
import FirebaseDatabase

class DatabaseViewModel {
    private let databaseRef = Database.database().reference()
    var onDataFetch: (() -> Void)?
    var user: UserModel?
    
    func saveUser(_ user: UserModel) {
        let userRef = databaseRef.child("USERS").child(user.id)
        userRef.setValue(["email": user.email,
                          "username": user.username,
                          "bio": user.bio,
                          "profileUrl": user.profileUrl])
    }
    func fetchDataFromDatabase(withID id: String, completion: ((_ user: UserModel) -> Void)?)   {
        let databaseRef = databaseRef.child("USERS").child(id)
        databaseRef.observe(.value) { (snapshot: DataSnapshot) in
            if let userData = snapshot.value as? [String: String],
               let email = userData["email"],
               let username = userData["username"],
               let bio = userData["bio"],
               let profileUrl = userData["profileUrl"]
            {
                
                let user = UserModel(id: id, email: email, username: username, bio: bio, profileUrl: profileUrl)
                completion?(user)
            }
        }
    }
}

