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
    
    var body: some View {
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
    }
}
