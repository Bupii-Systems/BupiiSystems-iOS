//
//  LoginView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/04/2025.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            BackgroundLoginView(imageName: "LogoDefault")

            VStack(spacing: 0) {
                Text("Login")
                    .foregroundStyle(Color(AppColor.text))
                    .font(.custom("Inter-Bold", size: 18))
                    .padding(.top, 254)
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                GenericTextField(leftImageName: "PersonColor", isPasswordField: false, placeholder: "Digite seu email")
                    .padding(.top, 24)
                
                GenericTextField(leftImageName: "LockColor", isPasswordField: true, placeholder: "Digite a senha")
                    .padding(.top, 24)

                VStack(alignment: .trailing, spacing: 2) {
                    Button(action: {
                        print("Forgot password tapped.")
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
                    print("Entrar tapped")
                })
                .padding(.top, 24)

                VStack(spacing: 0) {
                    VStack(spacing: 2) {
                        Button(action: {
                            print("Entrar sem cadastro tapped")
                        }) {
                            Text("Entrar sem cadastro")
                                .foregroundStyle(Color(AppColor.brand))
                                .font(.custom("Inter-Regular", size: 16))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }

                        Rectangle()
                            .foregroundColor(Color(AppColor.brand))
                            .frame(height: 1)
                            .frame(width: 146)
                    }
                    .padding(.top, 24)

                    Text("Entrar utilizando:")
                        .foregroundStyle(Color(AppColor.text))
                        .font(.custom("Inter-Bold", size: 18))
                        .padding(.top, 34)

                    HStack(spacing: 24) {
                        Button(action: {
                            print("Login with Apple tapped")
                        }) {
                            Image("LoginWithApple")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .background(Color(hexColor("#E6E6E6")))
                                .clipShape(Circle())
                        }

                        Button(action: {
                            print("Login with Google tapped")
                        }) {
                            Image("LoginWithGoogle")
                                .resizable()
                                .frame(width: 48, height: 48)
                                .background(Color(hexColor("#E6E6E6")))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.top, 8)

                    Text("Ainda não tem uma conta?")
                        .foregroundStyle(Color(AppColor.text))
                        .font(.custom("Inter-Regular", size: 16))
                        .padding(.top, 32)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Button(action: {
                        print("Clique aqui para se cadastrar tapped")
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
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LoginView()
}
