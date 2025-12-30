//
//  AuthViewModel.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/29/25.
//

import SwiftUI
import Combine
import FirebaseAuth
import FirebaseFirestore

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String?
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    // MARK: - Signup function
    func signup(firstName: String, lastName: String, email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            // Check for errors
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            
            guard let firebaseUser = result?.user else { return }
            
            // Create a new user
            let newUser = UserModel(
                id: firebaseUser.uid,
                firstName: firstName,
                lastName: lastName,
                email: email
            )
            
            // Save to firestore
            do {
                try self?.db.collection("users").document(firebaseUser.uid).setData(from: newUser)
                self?.user = newUser
                self?.isLoggedIn = true
            } catch {
                self?.errorMessage = error.localizedDescription
            }
        }
    }
    
    // MARK: - Login function
    func login(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            // Check for errors
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            // Fetch user data from Firestore (and not Auth)
            self?.db.collection("users").document(uid).getDocument { snapshot, error in
                if let error = error {
                    Task { @MainActor in
                        self?.errorMessage = error.localizedDescription
                    }
                    return
                }
                
                Task { @MainActor in
                    if let snapshot = snapshot, snapshot.exists {
                        do {
                            let fetchedUser = try snapshot.data(as: UserModel.self)
                            self?.user = fetchedUser
                            self?.isLoggedIn = true
                        } catch {
                            self?.errorMessage = error.localizedDescription
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Logout function
    
}

