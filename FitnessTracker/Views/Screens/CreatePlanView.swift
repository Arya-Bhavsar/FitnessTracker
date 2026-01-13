//
//  CreatePlanView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/30/25.
//

import SwiftUI

struct CreatePlanView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: - Link to create a new plan manually
                NavigationLink {
                    if let userID = authVM.user?.id {
                        ManualPlanView(workoutPlanVM: WorkoutPlanViewModel(userID: userID))
                    }
                } label: {
                    HStack {
                        Image(systemName: "pencil.line")
                            .font(.title)
                            .foregroundColor(.primary)
                        
                        Text("Create Plan Manually")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.secondarySystemGroupedBackground))
                            .shadow(radius: 3)
                    )
                }
                
                // Footer note for the manual option
                Text("Create your plan manually by choosing days and exercises. You can edit a plan later anytime.")
                    .padding(.top, 5)
                    .padding(.bottom, 30)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                // MARK: - Link to create a new plan using AI
                NavigationLink {
                    AIPlanView()
                } label: {
                    HStack {
                        Image(systemName: "sparkles")
                            .font(.title)
                            .foregroundColor(.primary)
                            
                        
                        Text("Use AI to Create Plan")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(
                        ZStack {
                            // Glow behind the card
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(
                                    LinearGradient(
                                        colors: [.blue, .purple, .red],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 4
                                )
                                .blur(radius: 4)
                                
                            
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(.secondarySystemGroupedBackground))
                        }
                    )
                }
                
                // Footer note for the AI option
                Text("Generate a plan with the help of AI. Fill out a form and the AI will generate a plan for you. You can also modify the generated plan manually.")
                    .padding(.top, 5)
                    .padding(.bottom, 40)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Create a New Plan")

        }
    }
}

#Preview {
    CreatePlanView()
}
