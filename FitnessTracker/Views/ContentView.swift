//
//  ContentView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/28/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TopBarView()
            
            // Placeholder
            List {
                Text("Test")
            }
        }
    }
}

#Preview {
    // Mock User for preview
    let mockVM = AuthViewModel()
    mockVM.user = UserModel(id: "1", firstName: "Arya", lastName: "Bhavsar", email: "aryab2914@gmail.com")
    return ContentView()
        .environmentObject(mockVM)
}
