//
//  BupiiApp.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 22/04/2025.
//

import SwiftUI
import Firebase

@main
struct BupiiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            AppEntryView()
        }
    }
}
