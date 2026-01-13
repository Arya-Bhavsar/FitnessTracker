//
//  WorkoutPlanViewModel.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 1/8/26.
//

import Foundation
import FirebaseFirestore
import Combine

// Day plan struct
struct DayPlan: Identifiable {
    var id = UUID()
    var name: String
    var isRestDay: Bool = false
    var exercises: [String] = []
}

@MainActor
class WorkoutPlanViewModel: ObservableObject {
    @Published var weekPlans: [DayPlan] = [
        DayPlan(name: "Monday"),
        DayPlan(name: "Tuesday"),
        DayPlan(name: "Wednesday"),
        DayPlan(name: "Thursday"),
        DayPlan(name: "Friday"),
        DayPlan(name: "Saturday"),
        DayPlan(name: "Sunday")
    ]
    
    @Published var savedPlans: [WorkoutPlanModel] = []
    
    private let db = Firestore.firestore()
    private let userID: String
    
    init(userID: String) {
        self.userID = userID
    }
    
    // MARK: - Function to save a plan
    func savePlan(name: String) {
        var daysData: [String: DayPlanData] = [:]
        
        // Create the day/exercises map for the workout plan model
        for day in weekPlans {
            daysData[day.name] = DayPlanData(isRestDay: day.isRestDay, exercises: day.exercises)
        }
        
        // Create the workout plan
        let plan = WorkoutPlanModel(name: name, days: daysData)
        
        // Add the plan under the current user
        do {
            try _ = db.collection("users").document(userID).collection("workoutPlans").addDocument(from: plan)
        } catch {
            print("Error saving the plan:", error.localizedDescription)
        }
    }
    
    // MARK: - Function to get all the saveed plans
    func fetchPlans() async {
        do {
            // Gets the snapshot for the plans
            let plans = try await db.collection("users")
                .document(userID)
                .collection("workoutPlans")
                .order(by: "createAt", descending: true)
                .getDocuments()
            
            //Updates the saved plans variable for the view
            self.savedPlans = plans.documents.compactMap { doc in
                try? doc.data(as: WorkoutPlanModel.self)
            }
        } catch {
            print("Error fetching plans.")
        }
    }
}

