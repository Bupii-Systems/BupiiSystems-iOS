//
//  TeamView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 10/05/2025.
//

import SwiftUI
import AVKit

// MARK: - TeamMemberDetailView

struct TeamMemberDetailView: View {
    let member: TeamMemberModel
    let onPrevious: () -> Void
    let onNext: () -> Void
    let canGoPrevious: Bool
    let canGoNext: Bool

    var body: some View {
        VStack(spacing: 0) {
            Image(member.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 188, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(AppColor.brand), lineWidth: 2)
                )

            HStack {
                Button(action: onPrevious) {
                    Image("ArrowLeft")
                        .padding(.leading, 16)
                }
                .disabled(!canGoPrevious)

                Text(member.name)
                    .font(.custom("Inter-Bold", size: 16))
                    .foregroundColor(Color(AppColor.brand))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 12)

                Button(action: onNext) {
                    Image("ArrowRight")
                        .padding(.trailing, 16)
                }
                .disabled(!canGoNext)
            }

            VStack(spacing: 0) {
                Text(member.role)
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundColor(Color(AppColor.brand))
                    .padding(.top, 4)

                Text(member.description)
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundColor(Color(AppColor.brand))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.top, 19)
            }
        }
        .padding(.top, 24)
    }
}

// MARK: - TeamVideoView

struct TeamVideoView: View {
    var body: some View {
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
    }
}

// MARK: - TeamView

struct TeamView: View {
    @State private var selectedItemIndex: Int? = 0

    private let teamMembers: [TeamMemberModel] = [
        TeamMemberModel(
            name: "Vinicius Alpes",
            role: "Barbeiro",
            description: "Especialista em visagismo, platinados.",
            imageName: "Person1"
        ),
        TeamMemberModel(
            name: "Pedro Santos",
            role: "Cabeleireiro",
            description: "Atua com cortes modernos e atendimento humanizado.",
            imageName: "Person2"
        ),
        TeamMemberModel(
            name: "Maria Oliveira",
            role: "Designer",
            description: "Focado em design de sobrancelhas e barba.",
            imageName: "Person3"
        ),
        TeamMemberModel(
            name: "João Silva",
            role: "Colorista",
            description: "Especialista em coloração e tratamento capilar.",
            imageName: "Person4"
        )
    ]

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
                            TeamMemberDetailView(
                                member: teamMembers[index],
                                onPrevious: {
                                    if index > 0 { selectedItemIndex = index - 1 }
                                },
                                onNext: {
                                    if index < teamMembers.count - 1 { selectedItemIndex = index + 1 }
                                },
                                canGoPrevious: index > 0,
                                canGoNext: index < teamMembers.count - 1
                            )
                        }

                        CarouselBookingView(
                            selectedItemIndex: $selectedItemIndex,
                            checkBoxState: .constant(false),
                            images: teamMembers.map { $0.imageName },
                            names: teamMembers.map { $0.name }
                        )

                        Text("Conheça nosso espaço")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 18))
                            .padding(.top, 24)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        TeamVideoView()

                        Spacer().frame(height: 160)
                    }
                }
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

// MARK: - Preview

#Preview {
    TeamView()
}
