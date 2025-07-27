//
//  SignUpView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 27/04/2025.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showSuccessAlert: Bool = false
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        ZStack {
            BackgroundSecondaryView(title: "Cadastro", onBackButtonTap: {
                dismiss()
            })
            VStack {
                Text("Para se cadastrar preencha os dados abaixo")
                    .foregroundStyle(Color(AppColor.text))
                    .font(.custom("Inter-Bold", size: 16))
                    .padding(.top, 136)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                GenericTextField(text: $name, leftImageName: "PersonColor", isPasswordField: false, placeholder: "Digite seu nome")
                    .padding(.top, 32)
                
                GenericTextField(text: $email, leftImageName: "PersonColor", isPasswordField: false, placeholder: "Digite seu e-mail")
                    .padding(.top, 16)
                
                GenericTextField(text: $password, leftImageName: "PersonColor", isPasswordField: true, placeholder: "Digite sua senha")
                    .padding(.top, 16)
                
                GenericTextField(text: $confirmPassword, leftImageName: "PersonColor", isPasswordField: true, placeholder: "Confirme sua senha")
                    .padding(.top, 16)
                
                Spacer()
                
                MainButton(buttonText: "Confirmar", action: {
                    guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
                        print("Every fields need to have text")
                        return
                    }

                    guard password == confirmPassword else {
                        print("Password and confirm password are different's.")
                        return
                    }

                    signUp(name: name, email: email, password: password) { result in
                        switch result {
                        case .success(let user):
                            print("Sign up successfull: \(user.email ?? "")")
                            showSuccessAlert = true
                        case .failure(let error):
                            print("Error sign up: \(error.localizedDescription)")
                        }
                    }
                })
                
                SecondaryButton(buttonText: "Registrar staff", action: {
                    print("tapped")
                })
                .padding(.bottom, 56)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .overlay(
            showSuccessAlert ?
                AlertOneButtonView(
                    message: "Conta criada com sucesso!\nVocê já pode fazer login.",
                    buttonText: "Voltar para o login",
                    onButtonTap: {
                        showSuccessAlert = false
                        dismiss()
                    }
                )
            : nil
        )
    }
}

#Preview {
    SignUpView()
}
