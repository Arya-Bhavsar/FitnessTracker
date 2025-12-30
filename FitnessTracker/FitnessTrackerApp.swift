//
//  FitnessTrackerApp.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/28/25.
//

import SwiftUI
import Firebase

@main
struct FitnessTrackerApp: App {
    // Initialize Firebase when the app starts
    init() {
        FirebaseApp.configure()
        print("Firebase is configured: \(FirebaseApp.app() != nil)")
    }
    
    @StateObject var authVM = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authVM.isLoggedIn {
                ContentView()
                    .environmentObject(authVM)
            } else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}
