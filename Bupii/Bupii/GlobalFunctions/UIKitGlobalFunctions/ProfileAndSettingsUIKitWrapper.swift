//
//  ProfileAndSettingsUIKitWrapper.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/06/2025.
//

import Foundation
import SwiftUI

// This struct allows the use of a UIKit view controller inside a SwiftUI app.

struct ProfileAndSettingsUIKitWrapper: UIViewControllerRepresentable {
    let model: ProfileModel

    func makeUIViewController(context: Context) -> ProfileAndSettingsViewController {
        return ProfileAndSettingsViewController(model: model)
    }

    func updateUIViewController(_ uiViewController: ProfileAndSettingsViewController, context: Context) {
        
    }
}
