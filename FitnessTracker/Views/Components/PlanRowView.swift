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
        NavigationLink {
            PlanDetailsView(plan: plan)
        } label: {
            HStack {
                // Plan name is highlighted if it is the current plan
                Text(plan.name)
                    .foregroundColor(plan.id == workoutPlanVM.currentPlanID ? .blue : .primary)
                
                // Conditionally render a checkmark if the plan is set as the current plan
                if plan.id == workoutPlanVM.currentPlanID {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                // Menu for the plan. Options include select a plan as the current plan or delete a plan
                Menu {
                    if plan.id == workoutPlanVM.currentPlanID {
                        // Button to follow a plan
                        Button("Unfollow Plan", systemImage: "minus.circle") {
                            Task {
                                await workoutPlanVM.unfollowPlan()
                            }
                        }
                    } else {
                        // Button to unfollow a plan
                        Button("Follow Plan", systemImage: "checkmark.circle") {
                            Task {
                                await workoutPlanVM.followPlan(plan: plan)
                            }
                        }
                    }
                    
                    // Button to delete the plan
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
}
