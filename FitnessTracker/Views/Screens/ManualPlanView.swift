//
//  ManualPlanView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 1/7/26.
//

import SwiftUI

struct ManualPlanView: View {
    @EnvironmentObject var workoutPlanVM: WorkoutPlanViewModel
    
    @State var planName: String = ""
    
    // To pop current view from stack, i.e. go back after saving a plan
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                // Plan Name TextField
                Section("Plan Name") {
                    TextField("Enter a plan name", text: $planName)
                }
                
                // MARK: - Section for each day of the week
                ForEach($workoutPlanVM.weekPlans) { $day in
                    Section(day.name) {
                        // Toggle for rest day
                        Toggle("Rest Day", isOn: $day.isRestDay)
                        
                        // List of exercises if not rest day
                        if !day.isRestDay {
                            ForEach(day.exercises.indices, id: \.self) { index in
                                TextField("Exercise", text: $day.exercises[index])
                            }
                            
                            // Button to create an empty TextField
                            Button("Add Exercise", action: {
                                day.exercises.append("")
                            })
                        }
                    }
                }
                
                // MARK: - Save Button
                Section(
                    footer: Text("Navigate to the \"Saved Plans\" tab to see all your plans.")
                ) {
                    Button("Save Plan") {
                        Task {
                            await workoutPlanVM.savePlan(name: planName)
                        }
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .disabled(planName.isEmpty)
                }
                .listRowBackground(Color.blue)
            }
            .navigationTitle("Weekly Plan")
        }
    }
}
