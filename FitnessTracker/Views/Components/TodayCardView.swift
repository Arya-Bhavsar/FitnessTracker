//
//  TodayCardView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 1/2/26.
//

import SwiftUI

// State enum for today
enum TodayState {
    case noActivePlan
    case restDay
    case workout([String])
}

struct TodayCardView: View {
    let todayState: TodayState
    
    // MARK: - Main today card view
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today")
                .font(.title)
                .fontWeight(.bold)
            
            content
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .shadow(radius: 4)
        )
    }
    
    // MARK: - Conditional views for the card
    @ViewBuilder
    private var content: some View {
        switch todayState {
        case .noActivePlan:
            Text("No active plan is selected")
                .foregroundStyle(.secondary)
        case .restDay:
            Text("Rest day")
                .foregroundStyle(.secondary)
        case .workout(let exercises):
            // List of exercises
            VStack(alignment: .leading) {
                ForEach(exercises, id: \.self) { exercise in
                    Text(exercise)
                }
            }
        }
    }
}

#Preview {
    TodayCardView(todayState: .noActivePlan)
    TodayCardView(todayState: .restDay)
    
    TodayCardView(todayState: .workout(["Push-ups", "Lunges", "Plank"]))
}
