//
//  GenericTextField.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 25/04/2025.
//

import SwiftUI

struct GenericTextField: View {
    @State private var text = ""
    @State private var isSecure: Bool = true
    var leftImageName: String
    var isPasswordField: Bool

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 56)
                .cornerRadius(8)
                .zIndex(0)

            HStack {
                Image(leftImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 16)

                if isPasswordField {
                    if isSecure {
                        SecureField("Enter text", text: $text)
                            .padding(10)
                            .background(Color.clear)
                            .cornerRadius(8)
                            .font(.custom("Inter-Regular", size: 16))
                            .foregroundStyle(Color(AppColor.text))
                    } else {
                        TextField("Enter text", text: $text)
                            .padding(10)
                            .background(Color.clear)
                            .cornerRadius(8)
                            .font(.custom("Inter-Regular", size: 16))
                            .foregroundStyle(Color(AppColor.text))
                    }

                    Button(action: {
                        withAnimation {
                            isSecure.toggle()
                        }
                    }) {
                        Image("Eye")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.trailing, 16)
                    }
                } else {
                    TextField("Enter text", text: $text)
                        .padding(10)
                        .background(Color.clear)
                        .cornerRadius(8)
                        .font(.custom("Inter-Regular", size: 16))
                        .foregroundStyle(Color(AppColor.text))
                }
            }
            .zIndex(1)
        }
        .frame(height: 56)
        .padding(.horizontal, 16)
    }
}

#Preview {
    GenericTextField(leftImageName: "LockColor", isPasswordField: true)
        .preferredColorScheme(.dark)
}
