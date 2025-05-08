//
//  FormattedFunctions.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 05/05/2025.
//

import SwiftUI

private func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter.string(from: date)
}

private func formatTime(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter.string(from: date)
}
