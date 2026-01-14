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
    @StateObject var planVM: WorkoutPlanViewModel = .init(userID: "")
    
    var body: some View {
        VStack {
            List {
                Text("Plan 1")
                Text("Plan 2")
                Text("Plan 3")
            }
        }
        .task(id: authVM.user?.id) {
            // Updates the user id initially to the correct one
            guard let userID = authVM.user?.id else { return }
            planVM.configure(userID: userID)
            
            await planVM.fetchPlans()
        }
    }
}
