//
//  PlanCardView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 1/19/26.
//

import SwiftUI

struct PlanRowView: View {
    @EnvironmentObject var workoutPlanVM: WorkoutPlanViewModel
    
    let plan: WorkoutPlanModel
    @State private var showDeletePlanAlert: Bool = false
    
    var body: some View {
        HStack {
            Text(plan.name)
            
            Spacer()
            
            // Menu for the plan. Options include select a plan as the current plan or delete a plan
            Menu {
                Button("Select Plan", systemImage: "checkmark.circle") {
                    //
                }
                
                Button("Delete Plan", systemImage: "trash", role: .destructive) {
                    showDeletePlanAlert = true
                }
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.black)
            }
            .alert("Are you sure you want to delete the plan?", isPresented: $showDeletePlanAlert) {
                // Alert to delete a plan
                Button("Confirm", role: .destructive) {
                    Task {
                        await workoutPlanVM.deletePlan(plan: plan)
                    }
                }
            }
        }
    }
}
