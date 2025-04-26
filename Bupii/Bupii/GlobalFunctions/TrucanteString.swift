//
//  TrucanteString.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/04/2025.
//

import SwiftUI
import Foundation

// to limite the number of caracteres
func truncate(_ text: String, limit: Int) -> String {
    if text.count > limit {
        let index = text.index(text.startIndex, offsetBy: limit)
        return "\(text[..<index])..."
    } else {
        return text
    }
}
