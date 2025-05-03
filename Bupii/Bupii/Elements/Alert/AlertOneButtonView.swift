//
//  AlertOneButtonView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 02/05/2025.
//

import SwiftUI

struct AlertOneButtonView: View {
    let message: String
    let buttonText: String
    let onButtonTap: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()

            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(.white)
                    .frame(minHeight: 275)

                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            print("XClose button tapped!")
                        }) {
                            Image("XClose")
                                .resizable()
                                .frame(width: 16.92, height: 16.92)
                        }
                        .padding(.top, 24)
                        .padding(.trailing, 20)
                    }

                    Text(message)
                        .font(.custom("Inter-Regular", size: 18))
                        .foregroundStyle(AppColor.text)
                        .multilineTextAlignment(.center)
                        .padding(.top, 43)
                        .padding(.horizontal, 32)

                    Spacer(minLength: 24)

                    MainButton(buttonText: buttonText, action: onButtonTap)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 49)
                }
                .padding(.bottom, 0)
            }
            .padding(.horizontal, 16)
            .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AlertOneButtonView(
        message: "Seu agendamento foi confirmado com sucesso!\nMuito obrigado!\nNos vemos em breve.",
        buttonText: "Concluir",
        onButtonTap: {
            print("Botão pressionado")
        }
    )
}
