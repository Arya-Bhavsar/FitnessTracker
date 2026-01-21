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
    @StateObject var workoutPlanVM: WorkoutPlanViewModel = .init(userID: "")
    
    var body: some Scene {
        WindowGroup {
            if authVM.isLoggedIn {
                ContentView()
                    .task {
                        // Initialize workoutPlanVM
                        guard let userID = authVM.user?.id else { return }
                        workoutPlanVM.configure(userID: userID)
                        await workoutPlanVM.fetchPlans()
                        await workoutPlanVM.fetchCurrentPlanID()
                    }
                    .environmentObject(authVM)
                    .environmentObject(workoutPlanVM)
            } else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}
