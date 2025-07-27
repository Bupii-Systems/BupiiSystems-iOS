//
//  HomeViewModel.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 25/07/2025.
//

import Foundation
import FirebaseAuth

final class HomeViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var establishmentName: String = "BarbeariaRockeFeller"

    private let displayName: String?

    init(displayName: String? = Auth.auth().currentUser?.displayName) {
        self.displayName = displayName
        fetchUserName()
    }

    private func fetchUserName() {
        userName = displayName ?? "Visitante"
    }
}
