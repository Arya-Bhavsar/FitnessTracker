//
//  ManualPlanView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 1/7/26.
//

import SwiftUI

struct ManualPlanView: View {
    @StateObject var workoutPlanVM: WorkoutPlanViewModel
    @State var planName: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                // Plan Name TextField
                Section("Plan Name") {
                    TextField("Enter Plan Name", text: $planName)
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
                Section {
                    Button("Save Plan") {
                        workoutPlanVM.savePlan(name: planName)
                    }
                    .disabled(planName.isEmpty)
                }
            }
            .navigationTitle("Weekly Plan")
        }
    }
}
