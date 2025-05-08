//
//  SecondaryButton.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 23/04/2025.
//

import SwiftUI

struct SecondaryButton: View {
    var buttonText: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .foregroundColor(Color(AppColor.brand))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.custom("Inter", size: 16))
                .fontWeight(.bold)
        }
        .frame(height: 56)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(AppColor.brand), lineWidth: 2)
        )
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

struct SecondaryButtonRed: View {
    var buttonText: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(buttonText)
                .foregroundColor(hexColor("B81F1F"))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .font(.custom("Inter", size: 16))
                .fontWeight(.bold)
        }
        .frame(height: 56)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(hexColor("B81F1F"), lineWidth: 2)
        )
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

#Preview {
    SecondaryButton(buttonText: "Estilo de botão", action: {
        print("Botão pressionado!")
    })
}
