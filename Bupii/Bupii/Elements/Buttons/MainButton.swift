//
//  MainButton.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 23/04/2025.
// 


import SwiftUI

struct MainButton: View {
    var buttonText: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                Text(buttonText)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.white)
                    .font(.custom("Inter-Bold", size: 16))
            }
            .frame(height: 56)
            .background(Color(AppColor.brand))
            .cornerRadius(8)
            .padding(.horizontal, 16)
        }
    }
}

struct MainButtonWhite: View {
    var buttonText: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                Text(buttonText)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.brand)
                    .font(.custom("Inter-Bold", size: 16))
            }
            .frame(height: 56)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    MainButton(buttonText: "Clique aqui", action: {
        print("Botão pressionado!")
    })
}
