//
//  LoginView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/04/2025.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""

    @State private var goToSignUp = false
    @State private var goToForgotPassword = false
    @State private var goToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(AppColor.grayBackground)
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                ZStack {
                    BackgroundLoginView(imageName: "LogoDefault")
                    
                        VStack(spacing: 0) {
                            Text("Login")
                                .foregroundStyle(Color(AppColor.text))
                                .font(.custom("Inter-Bold", size: 18))
                                .padding(.top, 254)
                                .padding(.leading, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            GenericTextField(text: $email, leftImageName: "PersonColor", isPasswordField: false, placeholder: "Digite seu email")
                                .padding(.top, 24)
                            
                            GenericTextField(text: $password, leftImageName: "LockColor", isPasswordField: true, placeholder: "Digite a senha")
                                .padding(.top, 24)
                            
                            VStack(alignment: .trailing, spacing: 2) {
                                Button(action: {
                                    goToForgotPassword = true
                                }) {
                                    Text("Esqueci a senha")
                                        .foregroundStyle(Color(AppColor.text))
                                        .font(.custom("Inter-Regular", size: 16))
                                        .padding(.trailing, 16)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                
                                Rectangle()
                                    .foregroundColor(Color(AppColor.text))
                                    .frame(height: 1)
                                    .frame(width: 120)
                                    .padding(.trailing, 16)
                            }
                            .padding(.top, 24)
                            
                            MainButton(buttonText: "Entrar", action: {
                                guard !email.isEmpty, !password.isEmpty else {
                                    print("Write the email and password fields.")
                                    return
                                }
                                
                                login(email: email, password: password) { result in
                                    switch result {
                                    case .success(let user):
                                        print("Login realizado com: \(user.email ?? "")")
                                        goToHome = true
                                    case .failure(let error):
                                        print("Erro ao logar: \(error.localizedDescription)")
                                    }
                                }
                            })
                            .padding(.top, 24)
                            
                            VStack(spacing: 0) {
                                // Botão "Entrar sem cadastro" e seu retângulo foram removidos aqui
                                
                                Text("Entrar utilizando:")
                                    .foregroundStyle(Color(AppColor.text))
                                    .font(.custom("Inter-Bold", size: 18))
                                    .padding(.top, 34)
                                
                                HStack(spacing: 24) {
                                    Button(action: {
                                        if let rootVC = UIApplication.shared.connectedScenes
                                            .compactMap({ $0 as? UIWindowScene })
                                            .first?.windows.first?.rootViewController {
                                            
                                            signInWithGoogle(presenting: rootVC) { result in
                                                switch result {
                                                case .success(let user):
                                                    print("Google login with email: \(user.email ?? "")")
                                                    goToHome = true
                                                case .failure(let error):
                                                    print("Error Google login: \(error.localizedDescription)")
                                                }
                                            }
                                        }
                                    }) {
                                        Image("LoginWithGoogle")
                                            .resizable()
                                            .frame(width: 48, height: 48)
                                            .background(Color(hexColor("#E6E6E6")))
                                            .clipShape(Circle())
                                    }
                                }
                                .padding(.top, 12)
                                
                                Text("Ainda não tem uma conta?")
                                    .foregroundStyle(Color(AppColor.text))
                                    .font(.custom("Inter-Regular", size: 16))
                                    .padding(.top, 32)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                                Button(action: {
                                    goToSignUp = true
                                }) {
                                    Text("Clique aqui para se cadastrar")
                                        .foregroundStyle(Color(AppColor.brand))
                                        .font(.custom("Inter-Bold", size: 16))
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding(.top, 4)
                                }
                                
                                Rectangle()
                                    .foregroundColor(Color(AppColor.brand))
                                    .frame(height: 1)
                                    .frame(width: 230)
                            }
                            
                            Spacer()
                                .frame(height: 60)
                        }
                        .frame(minHeight: UIScreen.main.bounds.height)
                    }
                    .ignoresSafeArea()
                }
                .ignoresSafeArea()
            }

            .navigationDestination(isPresented: $goToHome) {
                ContentView()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goToSignUp) {
                SignUpView()
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goToForgotPassword) {
                ForgotPasswordView()
                    .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    LoginView()
}
