//
//  MyAgendaUtils.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 27/07/2025.
//

import Foundation
import SwiftUI

@ViewBuilder
private func iconRow(_ iconName: String, _ text: String) -> some View {
    HStack(spacing: 4) {
        Image(iconName)
            .renderingMode(.template)
            .frame(width: 24, height: 24)
            .foregroundStyle(AppColor.brand)
            .frame(width: 26)

        Text(text)
            .font(.custom("Inter-Regular", size: 16))
            .foregroundStyle(Color(AppColor.text))
    }
}
