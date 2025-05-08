//
//  AppointmentModel.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 05/05/2025.
//

import Foundation
import FirebaseFirestoreSwift

struct Appointment: Codable, Identifiable {
    @DocumentID var id: String?
    var userId: String
    var services: [String]
    var totalPrice: Double
    var date: String
    var time: String
    var professional: String
    var location: String
    var address: String
}
