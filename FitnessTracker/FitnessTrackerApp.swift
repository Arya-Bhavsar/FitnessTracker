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
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
