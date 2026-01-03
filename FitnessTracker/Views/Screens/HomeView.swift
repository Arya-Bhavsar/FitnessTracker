//
//  HomeView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/30/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            // The top bar with profile info
            TopBarView()
            
            // Main home screen content
            ScrollView {
                VStack(spacing: 12) {
                    // Card with today's workout goals
                    TodayCardView(todayState: .noActivePlan) // Hardcoded the state for now
                    
                    // More cards here
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemGroupedBackground))
        }
    }
}
