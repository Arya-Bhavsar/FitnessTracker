//
//  TodayCardView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 1/2/26.
//

import SwiftUI

struct TodayCardView: View {
    let currentPlan: WorkoutPlanModel?
    
    // Gets today's name using Calendar and Date
    private var today: String {
        let weekday = Calendar.current.component(.weekday, from: Date())
        let dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        return dayNames[weekday - 1].lowercased()
    }
    
    // Get todays plan (exercises or rest day)
    private var todayPlan: DayPlanData? {
        guard let currentPlan = currentPlan else { return nil }
        return currentPlan.days.first { $0.key.lowercased() == today }?.value
    }
    
    // MARK: - Main today card view
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Conditional view for the card
            content
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemGroupedBackground))
                        .shadow(radius: 4)
                )
        }
    }
    
    // MARK: - Conditional views for the card
    @ViewBuilder
    private var content: some View {
        if currentPlan == nil || todayPlan == nil {
            Text("No active workout plan.\nSelect a new plan to get started!")
                .foregroundStyle(.secondary)
        } else if todayPlan!.isRestDay {
            Text("Rest Day! Take a break today!")
                .foregroundStyle(.secondary)
        } else {
            // List of exercises for the day -- CHANGE IT TO HAVE A CHECKBOX TO MARK THEM COMPLETE
            VStack(alignment: .leading) {
                ForEach(todayPlan!.exercises, id: \.self) { exercise in
                    Text(exercise)
                }
            }
        }
    }
}
