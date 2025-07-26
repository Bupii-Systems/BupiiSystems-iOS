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

    init() {
        fetchUserName()
    }

    private func fetchUserName() {
        userName = Auth.auth().currentUser?.displayName ?? "Visitante"
    }
}
