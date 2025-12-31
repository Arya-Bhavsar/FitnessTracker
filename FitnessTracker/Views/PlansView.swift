//
//  PlansView.swift
//  FitnessTracker
//
//  Created by Arya Bhavsar on 12/30/25.
//

import SwiftUI

struct PlansView: View {
    var body: some View {
        VStack {
            TopBarView()
            
            List {
                Text("Plan 1")
                Text("Plan 2")
                Text("Plan 3")
            }
        }
    }
}
