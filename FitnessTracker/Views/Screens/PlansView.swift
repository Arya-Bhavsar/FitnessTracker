//
//  PlansView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/30/25.
//

import SwiftUI

struct PlansView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    // Initialize with empty userID
    @StateObject var workoutPlanVM: WorkoutPlanViewModel = .init(userID: "")
    
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workoutPlanVM.savedPlans) { plan in
                    Text(plan.name)
                }
            }
            .task(id: authVM.user?.id) {
                // Updates the user id initially to the correct one
                guard let userID = authVM.user?.id else { return }
                workoutPlanVM.configure(userID: userID)
                
                await workoutPlanVM.fetchPlans()
            }
            .toolbar {
                // Button to delete all plans
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .alert("Are you sure you want to delete all plans?", isPresented: $showDeleteAlert) {
                    Button("Confirm", role: .destructive) {
                        Task {
                            await workoutPlanVM.deleteAllPlans()
                        }
                    }
                }
            }
        }
    }
}
