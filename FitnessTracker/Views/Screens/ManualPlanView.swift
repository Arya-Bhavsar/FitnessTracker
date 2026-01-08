//
//  ManualPlanView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 1/7/26.
//

import SwiftUI

struct ManualPlanView: View {
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Monday")) {
                    Toggle("Rest Day", isOn: $isPresented)
                }
            }
            .navigationTitle("Weekly Plan")
        }
    }
}

#Preview {
    ManualPlanView()
}
