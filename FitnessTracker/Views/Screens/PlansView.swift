//
//  PlansView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/30/25.
//

import SwiftUI

struct PlansView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var workoutPlanVM: WorkoutPlanViewModel
    
    @State private var showDeleteAllAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            // list to print all the saved workout plans
            List {
                ForEach(workoutPlanVM.savedPlans) { plan in
                    PlanRowView(plan: plan)
                        .environmentObject(workoutPlanVM)
                }
            }
            .padding(.top)
            .navigationTitle("Saved Plans")
            .background(Color(.systemGroupedBackground))
            .toolbar {
                // Button to delete all plans
                Button {
                    showDeleteAllAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .alert("Are you sure you want to delete all plans?", isPresented: $showDeleteAllAlert) {
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
