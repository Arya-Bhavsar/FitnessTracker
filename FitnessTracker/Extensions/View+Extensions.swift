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
            .textFieldStyle(.roundedBorder)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color.blue : Color.clear)
            )
    }
}
