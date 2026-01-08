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
        switch todayState {
        case .noActivePlan:
            Text("No active workout plan\nSelect a new plan to get started!")
                .foregroundStyle(.secondary)
        case .restDay:
            Text("Rest day!\nTake a break today!")
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
