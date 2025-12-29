//
//  SignupView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/28/25.
//

import SwiftUI

struct SignupView: View {
    // Enums for the text fields
    enum Field {
        case firstName, lastName, email, password
    }
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .padding(10)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // First name text field
            TextField("First Name", text: $firstName)
                .focused($focusedField, equals: Field.firstName)
                .fieldStyle(isFocused: focusedField == Field.firstName)
                .padding(10)
            
            // Last name text field
            TextField("Last Name", text: $lastName)
                .focused($focusedField, equals: Field.lastName)
                .fieldStyle(isFocused: focusedField == Field.lastName)
                .padding(10)
            
            // Email text field
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .focused($focusedField, equals: Field.email)
                .fieldStyle(isFocused: focusedField == Field.email)
                .padding(10)
            
            // Password text field
            SecureField("Password", text: $password)
                .focused($focusedField, equals: Field.password)
                .fieldStyle(isFocused: focusedField == Field.password)
                .padding(10)
            
            // Sign up button
            Button {
                // Logic here
            } label: {
                Text("Sign Up")
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
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Needed to make empty space tappable
        .contentShape(Rectangle()) // Needed to make empty space tappable
        .onTapGesture { focusedField = nil }
        .padding()
    }
}

extension View {
    
}

#Preview {
    SignupView()
}
