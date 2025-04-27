//
//  SignUpView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 27/04/2025.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        ZStack {
            BackgroundSecondaryView(title: "Cadastro", onBackButtonTap: {
                print("tapped")
            })
            VStack {
                Text("Para se cadastrar preencha os dados abaixo")
                    .foregroundStyle(Color(AppColor.text))
                    .font(.custom("Inter-Bold", size: 16))
                    .padding(.top, 136)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                GenericTextField(leftImageName: "PersonColor", isPasswordField: false, placeholder: "Digite seu nome")
                    .padding(.top, 32)
                
                GenericTextField(leftImageName: "PersonColor", isPasswordField: false, placeholder: "Digite seu e-mail")
                    .padding(.top, 16)
                
                GenericTextField(leftImageName: "PersonColor", isPasswordField: true, placeholder: "Digite sua senha")
                    .padding(.top, 16)
                
                GenericTextField(leftImageName: "PersonColor", isPasswordField: true, placeholder: "Confirme sua senha")
                    .padding(.top, 16)
                
                Spacer()
                
                MainButton(buttonText: "Confirmar", action: {
                    print("tapped")
                })
                .padding(.bottom, 24)
                
                SecondaryButton(buttonText: "Registrar staff", action: {
                    print("tapped")
                })
                .padding(.bottom, 56)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    SignUpView()
}
