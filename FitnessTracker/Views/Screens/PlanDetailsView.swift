//
//  PlanDetailsView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 1/19/26.
//

import SwiftUI

struct PlanDetailsView: View {
    let plan: WorkoutPlanModel
    
    // Define the order for days of the week
    let dayOrder = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    var body: some View {
        List {
            ForEach(dayOrder, id: \.self) { day in
                // Print the exercises for the day
                if let dayPlan = plan.days[day] {
                    Section(day) {
                        if dayPlan.isRestDay {
                            Text("Rest Day")
                        } else {
                            ForEach(dayPlan.exercises, id: \.self) { exercise in
                                Text(exercise)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(plan.name)
    }
}
