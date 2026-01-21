//
//  WeeklyProgressView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 1/4/26.
//

import SwiftUI

struct WeeklyProgressView: View {
    @State private var selectedDay: Int = 0
    let currentPlan: WorkoutPlanModel?
    
    private let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private let dayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    // MARK: - Weekly Progress View
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Weekly Progress")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // MARK: - Day Picker
            Picker("Day", selection: $selectedDay) {
                ForEach(days.indices, id: \.self) { index in
                    Text(days[index]).tag(index)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 10)
            
            // MARK: - View for the selected day, if a plan is set as current plan
            if let currentPlan = currentPlan {
                VStack(alignment: .leading) {
                    if let dayPlan = currentPlan.days[dayNames[selectedDay]] {
                        // Print either rest day, or list of exercises
                        if dayPlan.isRestDay {
                            Text("Rest day")
                        } else {
                            ForEach(dayPlan.exercises, id: \.self) { exercise in
                                Text(exercise)
                            }
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemGroupedBackground))
                        .shadow(radius: 4)
                )
            } else {
                Text("No active workout plan.\nSelect a new plan to get started!")
                    .foregroundStyle(.secondary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.secondarySystemGroupedBackground))
                            .shadow(radius: 4)
                    )
            }
        }
    }
    
    // MARK: - Conditional views for the selected day
    @ViewBuilder
    private var dayContent: some View {
        switch selectedDay {
        case 0:
            Text("Monday")
        case 1:
            Text("Tuesday")
        case 2:
            Text("Wednesday")
        case 3:
            Text("Thursday")
        case 4:
            Text("Friday")
        case 5:
            Text("Saturday")
        case 6:
            Text("Sunday")
        default:
            Text("No data for this day")
        }
    }
}
