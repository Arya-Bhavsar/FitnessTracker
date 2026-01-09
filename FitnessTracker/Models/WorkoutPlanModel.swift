//
//  WorkoutPlanModel.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 1/8/26.
//

import Foundation
import FirebaseFirestore

// Struct to store exercises for a day
struct DayPlanData: Codable {
    var isRestDay: Bool
    var exercises: [String]
}

// MARK: - Workout Plan Model
struct WorkoutPlanModel: Identifiable, Codable {
    @DocumentID var id: String? // Firebase UID
    var name: String
    var days: [String: DayPlanData]
    var createdAt: Date = Date()
}
