//
//  ProfileAndSettingsViewModel.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 27/06/2025.
//

import Foundation
import FirebaseAuth
import SwiftUI

final class ProfileAndSettingsViewModel {
    
    private let model: ProfileModel

    var onLogout: (() -> Void)?

    init(model: ProfileModel) {
        self.model = model
    }

    var name: String? { model.name }
    var year: String? { model.year }
    var attendance: String? { model.attendance }
    var email: String? { model.email }
    var plan: String? { model.plan }
    var registrationType: String? { model.registrationType }

    func logout() {
        try? Auth.auth().signOut()
        UserDefaults.standard.set(false, forKey: "isLoggedIn") 
        onLogout?()
    }
}
