//
//  View+Extensions.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/29/25.
//

import SwiftUI

extension View {
    // Custom modifier for text fields with focus rings
    func fieldStyle(isFocused: Bool) -> some View {
        self
            .padding()
            .background(Color.black.opacity(0.05))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color.blue : Color.clear)
            )
    }
}
