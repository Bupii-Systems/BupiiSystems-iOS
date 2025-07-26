//
//  SubscriptionsCardView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 17/05/2025.
//

import SwiftUI

struct SubscriptionsFlowView: View {
    @State private var step = 0

    var body: some View {
        if step < 2 {
            SubscriptionsCardView(step: $step)
        } else {
            SubscriptionsCardView2()
        }
    }
}

struct SubscriptionsCardView: View {
    @Binding var step: Int

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    hexColor("00B4A0"),
                    hexColor("401FB8")
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 422)
            .cornerRadius(24)
            .overlay(
                VStack(spacing: 0) {
                    Image("XClose")
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 18)
                        .padding(.top, 32)

                    Image("Trophy")
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.trailing, 18)
                        .padding(.top, 32)

                    Text(currentText)
                        .font(.custom("Inter-Bold", size: 18))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                        .padding(.top, 20)

                    HStack {
                        Image("Circle")
                            .renderingMode(.template)
                            .foregroundStyle(.white)
                            .opacity(step == 0 ? 1 : 0.3)
                            .padding(.leading, 16)
                            .padding(.top, 32)

                        Image("Circle")
                            .renderingMode(.template)
                            .foregroundStyle(.white)
                            .opacity(step == 1 ? 1 : 0.3)
                            .padding(.leading, 16)
                            .padding(.top, 32)

                        Image("Circle")
                            .renderingMode(.template)
                            .foregroundStyle(.white)
                            .opacity(0.3)
                            .padding(.leading, 16)
                            .padding(.top, 32)
                    }
                    .padding(.top, 67)

                    MainButtonWhite(buttonText: "Próximo", action: {
                        step += 1
                    })
                    .padding(.top, 30)

                    Spacer()
                }
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 18)
    }

    var currentText: String {
        switch step {
        case 0:
            return "As assinaturas são uma maneira de incentivar nossos clientes a sempre estarem conosco."
        case 1:
            return "Você paga um valor uma única vez por mês e tem acesso ao nossos serviços de maneira ilimitada!"
        default:
            return ""
        }
    }
}

struct SubscriptionsCardView2: View {
    @State private var step = 0

    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Image("BackgroundPlans")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 694)
                    .clipped()
                    .cornerRadius(24)
                    .overlay(Color.black.opacity(0.5).cornerRadius(24))
                    .overlay(
                        VStack(spacing: 0) {
                            Image("XClose")
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 18)
                                .padding(.top, 32)

                            Text("Você paga menos e recebe mais")
                                .font(.custom("Inter-Bold", size: 18))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                                .padding(.top, 260)
                            
                            Text("Quer economizar e estar sempre na régua?")
                                .font(.custom("Inter-Bold", size: 28))
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 16)
                                .padding(.top, 20)
                            
                            HStack {
                                Image("Circle")
                                    .renderingMode(.template)
                                    .foregroundStyle(.white)
                                    .padding(.leading, 16)
                                    .padding(.top, 32)
                                
                                Image("Circle")
                                    .renderingMode(.template)
                                    .foregroundStyle(.white)
                                    .padding(.leading, 16)
                                    .padding(.top, 32)
                                
                                Image("Circle")
                                    .renderingMode(.template)
                                    .foregroundStyle(.white)
                                    .padding(.leading, 16)
                                    .padding(.top, 32)
                            }
                            .padding(.top, 67)

                            MainButtonWhite(buttonText: "Conhecer planos", action: {
                                if step < 2 {
                                    step += 1
                                }
                            })
                            .padding(.top, 30)
                            
                            SecondaryButtonTransparent(buttonText: "Talvez mais tarde", action: {
                                print("")
                            })
                            .padding(.top, 16)
                            
                            Spacer()
                                .frame(height: 30)
                        }
                    )
            }
            .padding(.horizontal, 18)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    var currentText: String {
        switch step {
        case 0:
            return "As assinaturas são uma maneira de incentivar nossos clientes a sempre estarem conosco."
        case 1:
            return "Você paga um valor uma única vez por mês e tem acesso ao nossos serviços de maneira ilimitada!"
        case 2:
            return "Assine agora e aproveite descontos incríveis toda semana."
        default:
            return ""
        }
    }
}

#Preview {
    SubscriptionsFlowView()
        .preferredColorScheme(.dark)
}


