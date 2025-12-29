//
//  LoginView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/28/25.
//

import SwiftUI

struct LoginView: View {
    // Enums for the text fields
    enum Field {
        case email, password
    }
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isPasswordVisible: Bool = false
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack {
            Text("Log In")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Email text field
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .focused($focusedField, equals: Field.email)
                .fieldStyle(isFocused: focusedField == Field.email)
                .padding(10)
            
            // Password field with show/hide password toggle
            ZStack(alignment: .trailing) {
                // Conditionally switches between text and secure fields
                Group {
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                }
                .autocapitalization(.none)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: Field.password)
                .fieldStyle(isFocused: focusedField == Field.password)
                .padding(10)
                
                // Button to toggle between show/hide password
                Button {
                    isPasswordVisible.toggle()
                } label: {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                }
                .padding(.trailing, 20)
            }
            
            // Log in button
            Button {
                // Logic here
            } label: {
                Text("Log In")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(15)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 10)
            .padding(.vertical, 30)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture { focusedField = nil }
        .padding()
    }
}

#Preview {
    LoginView()
}
