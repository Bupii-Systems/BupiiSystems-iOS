//
//  TeamView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 10/05/2025.
//

import SwiftUI
import AVKit

struct TeamView: View {
    @State private var selectedItemIndex: Int? = 0

    let names = ["Vinicius Alpes", "Pedro Santos", "João Silva", "Maria Oliveira"]
    let roles = ["Barbeiro", "Cabeleireiro", "Designer", "Colorista"]
    let descriptions = [
        "Especialista em visagismo, platinados e aqui uma descrição detalhada sobre o que o profissional faz e faz e faz.",
        "Atua com cortes modernos e atendimento humanizado.",
        "Focado em design de sobrancelhas e barba.",
        "Especialista em coloração e tratamento capilar."
    ]
    let images = ["Person1", "Person2", "Person3", "Person4"]

    var body: some View {
        ZStack {
            Color(AppColor.grayBackground).ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                ZStack {
                    BackgroundSecondaryView(title: "Equipe RockeFeller", onBackButtonTap: {
                        print("Voltar")
                    })

                    VStack(alignment: .center, spacing: 16) {
                        Text("Conheça nosso time")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 18))
                            .padding(.top, 118)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        if let index = selectedItemIndex {
                            VStack(spacing: 0) {
                                Image(images[index])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 188, height: 250)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(AppColor.brand), lineWidth: 2)
                                    )

                                HStack {
                                    Button {
                                        if index > 0 {
                                            selectedItemIndex = index - 1
                                        }
                                    } label: {
                                        Image("ArrowLeft")
                                            .padding(.leading, 16)
                                    }

                                    Text(names[index])
                                        .font(.custom("Inter-Bold", size: 16))
                                        .foregroundColor(Color(AppColor.brand))
                                        .frame(maxWidth: .infinity)
                                        .padding(.top, 12)

                                    Button {
                                        if index < names.count - 1 {
                                            selectedItemIndex = index + 1
                                        }
                                    } label: {
                                        Image("ArrowRight")
                                            .padding(.trailing, 16)
                                    }
                                }

                                VStack(spacing: 0) {
                                    Text(roles[index])
                                        .font(.custom("Inter-Regular", size: 16))
                                        .foregroundColor(Color(AppColor.brand))
                                        .padding(.top, 4)

                                    Text(descriptions[index])
                                        .font(.custom("Inter-Regular", size: 16))
                                        .foregroundColor(Color(AppColor.brand))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 32)
                                        .padding(.top, 19)
                                }
                            }
                            .padding(.top, 24)
                        }

                        CarouselBookingView(
                            selectedItemIndex: $selectedItemIndex,
                            checkBoxState: .constant(false),
                            images: images,
                            names: names
                        )

                        Text("Conheça nosso espaço")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 18))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        let videoWidth = UIScreen.main.bounds.width - 32
                        let videoHeight = videoWidth * 9 / 16

                        if let path = Bundle.main.path(forResource: "barber", ofType: "mp4") {
                            let player = AVPlayer(url: URL(fileURLWithPath: path))
                            VideoPlayer(player: player)
                                .frame(width: videoWidth, height: videoHeight)
                                .cornerRadius(12)
                                .padding(.horizontal, 16)
                                .onAppear {
                                    player.play()
                                }
                        } else {
                            Text("Vídeo não encontrado")
                                .frame(width: videoWidth, height: videoHeight)
                        }

                        Spacer().frame(height: 160)
                    }
                }
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TeamView()
}
