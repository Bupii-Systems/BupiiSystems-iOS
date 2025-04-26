//
//  BackgroundSecondaryView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/04/2025.
//

import SwiftUI

struct BackgroundSecondaryView: View {
    let title: String
    let onBackButtonTap: () -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundStyle(Color(AppColor.brand))
                    .frame(height: 378)
                Spacer()
            }
            .ignoresSafeArea(edges: .top)

            VStack(spacing: 0) {
                Spacer()
                Rectangle()
                    .foregroundStyle(hexColor("#F4F4F4"))
                    .cornerRadius(12)
                    .ignoresSafeArea(edges: .horizontal)
                    .padding(.top, 89)
            }
            .ignoresSafeArea()

            VStack {
                ZStack {
                    HStack {
                        Button(action: onBackButtonTap) {
                            Image("ArrowBack")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        .padding(.leading, 16)

                        Spacer()
                    }

                    Text(title)
                        .foregroundStyle(.white)
                        .font(.custom("Inter-Bold", size: 18))
                }
                .padding(.top, 56)

                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    BackgroundSecondaryView(
        title: "Cadastro",
        onBackButtonTap: {
            print("Back button tapped")
        }
    )
}
