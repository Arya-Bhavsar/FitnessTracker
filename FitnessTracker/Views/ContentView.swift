//
//  ContentView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/28/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showLogoutAlert: Bool = false
    
    var body: some View {
        VStack {
            // MARK: - Top bar
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                Text("\(authVM.user?.firstName ?? "Guest") \(authVM.user?.lastName ?? "")")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                // Logout button
                Button {
                    showLogoutAlert = true
                } label: {
                    Text("Log Out")
                        .fontWeight(.semibold)
                        .padding(10)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
                .alert("Are you sure you want to log out?", isPresented: $showLogoutAlert) {
                    Button("Confirm", role: .destructive) {
                        authVM.logout()
                    }
                }
            }
            .padding()
            
            // MARK: - Placeholder
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
