//
//  ForgotPasswordView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 27/04/2025.
//

import SwiftUI

struct ForgotPasswordView: View {
    var body: some View {
        ZStack {
            BackgroundSecondaryView(title: "Recuperação de senha", onBackButtonTap: {
                print("tapped")
            })
            VStack {
                Text("Para recuperar sua senha digite o e-mail cadastrado")
                    .foregroundStyle(Color(AppColor.text))
                    .font(.custom("Inter-Bold", size: 16))
                    .padding(.top, 136)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                GenericTextField(leftImageName: "PersonColor", isPasswordField: false, placeholder: "Digite seu e-mail")
                    .padding(.top, 32)
                
                Spacer() 
                
                MainButton(buttonText: "Confirmar", action: {
                    print("tapped")
                })
                .padding(.bottom, 56)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ForgotPasswordView()
}
