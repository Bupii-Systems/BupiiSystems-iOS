//
//  GenericTextField.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 25/04/2025.
//

import SwiftUI

struct GenericTextField: View {
    @Binding var text: String
    @State private var isSecure: Bool = true
    var leftImageName: String
    var isPasswordField: Bool
    var placeholder: String

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 56)
                .cornerRadius(8)
                .zIndex(0)

            HStack {
                Image(leftImageName)
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.leading, 16)
                    .foregroundStyle(AppColor.brand)

                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(Color(AppColor.text))
                            .font(.custom("Inter-Regular", size: 16))
                            .padding(.leading, 10)
                    }

                    if isPasswordField {
                        if isSecure {
                            SecureField("", text: $text)
                                .padding(10)
                                .background(Color.clear)
                                .font(.custom("Inter-Regular", size: 16))
                                .foregroundColor(Color(AppColor.text))
                        } else {
                            TextField("", text: $text)
                                .padding(10)
                                .background(Color.clear)
                                .font(.custom("Inter-Regular", size: 16))
                                .foregroundColor(Color(AppColor.text))
                        }
                    } else {
                        TextField("", text: $text)
                            .padding(10)
                            .background(Color.clear)
                            .font(.custom("Inter-Regular", size: 16))
                            .foregroundColor(Color(AppColor.text))
                    }
                }

                if isPasswordField {
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
                }
            }
            .zIndex(1)
        }
        .frame(height: 56)
        .padding(.horizontal, 16)
    }
}

//#Preview {
//    GenericTextField(
//        leftImageName: "LockColor",
//        isPasswordField: true,
//        placeholder: "Digite sua senha"
//    )
//    .preferredColorScheme(.dark)
//}
