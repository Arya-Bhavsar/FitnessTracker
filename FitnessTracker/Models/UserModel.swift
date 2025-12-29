//
//  UserModel.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/29/25.
//

import FirebaseFirestore

struct UserModel: Identifiable, Codable {
    @DocumentID var id: String? // Firebase UID
    var firstName: String
    var lastName: String
    var email: String
}
