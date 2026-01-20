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
    @Published var currentPlanID: String?
    
    // The current plan set by the user
    var currentPlan: WorkoutPlanModel? {
        guard let id = currentPlanID else { return nil }
        return savedPlans.first(where: { $0.id == id })
    }
    
    private let db = Firestore.firestore()
    private var userID: String
    
    init(userID: String) {
        self.userID = userID
    }

    func configure(userID: String) {
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
                .order(by: "createdAt", descending: true)
                .getDocuments()
            
            //Updates the saved plans variable for the view
            self.savedPlans = plans.documents.compactMap { doc in
                try? doc.data(as: WorkoutPlanModel.self)
            }
        } catch {
            print("Error fetching plans:", error.localizedDescription)
        }
    }
    
    // MARK: - Function to delete all the saved plans
    func deleteAllPlans() async {
        do {
            let snapshot = try await db.collection("users")
                .document(userID)
                .collection("workoutPlans")
                .getDocuments()
            
            let batch = db.batch()
            
            // Removes all the savedPlans documents
            for plan in snapshot.documents {
                batch.deleteDocument(plan.reference)
            }
            
            try await batch.commit()
            
            // Updates the UI
            self.savedPlans.removeAll()
        } catch {
            print("Error deleting plans:", error.localizedDescription)
        }
    }
    
    // MARK: - Function to delete a plan
    func deletePlan(plan: WorkoutPlanModel) async {
        // Make sure the plan has an id
        guard let planID = plan.id else { return }
        
        do {
            try await db.collection("users").document(userID).collection("workoutPlans").document(planID).delete()
            
            if let index = self.savedPlans.firstIndex(where: { $0.id == planID }) {
                self.savedPlans.remove(at: index)
            }
        } catch {
            print("Error deleting the plan:", error.localizedDescription)
        }
    }
    
    // MARK: - Function to set a plan as the current plan
    func setCurrentPlan(plan: WorkoutPlanModel) async {
        guard let planID = plan.id else { return }
        
        // Set the current plan
        self.currentPlanID = planID
        try? await db.collection("users").document(userID).updateData(["currentPlanID": planID])
    }
    
    // MARK: - Function to get the current plan if it exists
    func fetchCurrentPlanID() async {
        do {
            let snapshot = try await db.collection("users").document(userID).getDocument()
            
            // safely gets the current plan id
            self.currentPlanID = snapshot.data()?["currentPlanID"] as? String
        } catch {
            print("Error fetching the current plan:", error.localizedDescription)
        }
    }
}

