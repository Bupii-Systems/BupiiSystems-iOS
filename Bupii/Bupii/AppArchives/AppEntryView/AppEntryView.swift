//
//  AppEntryView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 03/05/2025.
//

import SwiftUI
import FirebaseAuth

struct AppEntryView: View {
    @State private var isLoggedIn = false

    var body: some View {
        Group {
            if isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            isLoggedIn = Auth.auth().currentUser != nil
        }
    }
}
