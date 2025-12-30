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
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var isPasswordVisible: Bool = false
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // MARK: - first name text field
                TextField("First Name", text: $firstName)
                    .focused($focusedField, equals: Field.firstName)
                    .fieldStyle(isFocused: focusedField == Field.firstName)
                    .padding(10)
                
                // MARK: - last name text field
                TextField("Last Name", text: $lastName)
                    .focused($focusedField, equals: Field.lastName)
                    .fieldStyle(isFocused: focusedField == Field.lastName)
                    .padding(10)
                
                // MARK: - email text field
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .focused($focusedField, equals: Field.email)
                    .fieldStyle(isFocused: focusedField == Field.email)
                    .padding(10)
                
                // MARK: - password field with show/hide password toggle
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
                
                // MARK: - signup button
                Button {
                    authVM.signup(firstName: firstName, lastName: lastName, email: email, password: password)
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
                .padding(.top, 30)
                
                // MARK: - navigation to the login page
                HStack {
                    Text("Already have an account?")
                    NavigationLink("Log In", destination: LoginView())
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Needed to make empty space tappable
            .contentShape(Rectangle()) // Needed to make empty space tappable
            .onTapGesture { focusedField = nil }
            .padding()
        }
    }
}

extension View {
    
}

#Preview {
    SignupView()
}
