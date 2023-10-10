//
//  UserModel.swift
//  TensorAssignment
//
//  Created by EAD on 09/10/23.
//

import Foundation

struct UserModel {
    var id: String
    var email: String
    var username: String
    var bio: String
    var profileUrl: String

    init(id: String, email: String, username: String, bio: String, profileUrl: String) {
        self.id = id
        self.email = email
        self.username = username
        self.bio = bio
        self.profileUrl = profileUrl
    }
}
