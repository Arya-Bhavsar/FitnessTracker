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

#Preview {
    // Mock User for preview
    let mockVM = AuthViewModel()
    mockVM.user = UserModel(id: "1", firstName: "Arya", lastName: "Bhavsar", email: "aryab2914@gmail.com")
    return ManualPlanView(workoutPlanVM: WorkoutPlanViewModel(userID: mockVM.user!.id!))
}
