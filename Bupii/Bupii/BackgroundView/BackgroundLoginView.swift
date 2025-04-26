//
//  BackgroundView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/04/2025.
//

import SwiftUI

struct BackgroundLoginView: View {
    let imageName: String

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
                    .padding(.top, 231)
            }
            .ignoresSafeArea()

            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 140)
                    .frame(width: 203)
                    .padding(.top, 60)
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    BackgroundLoginView(imageName: "LogoDefault")
}
