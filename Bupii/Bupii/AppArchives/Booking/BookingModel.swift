//
//  BookingModel.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 02/05/2025.
//

import Foundation

enum DurationUnit {
    case minutes
    case hours
}

struct Service {
    let name: String
    let duration: Int
    let durationUnit: DurationUnit
    let price: Double
}
