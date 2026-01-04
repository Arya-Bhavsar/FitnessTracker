//
//  WeeklyProgressView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 1/4/26.
//

import SwiftUI

struct WeeklyProgressView: View {
    @State private var selectedDay: Int = 0
    
    private let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    // MARK: - Weekly Progress View
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Weekly Progress")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Day Picker
            Picker("Day", selection: $selectedDay) {
                ForEach(days.indices, id: \.self) { index in
                    Text(days[index]).tag(index)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 10)
            
            // View for the selected day
            dayContent
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemGroupedBackground))
                        .shadow(radius: 4)
                )
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
