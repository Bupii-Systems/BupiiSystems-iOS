//
//  BackgroundHomeView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/04/2025.
//

import SwiftUI

struct BackgroundHomeView: View {
    let establishmentName: String
    let userName: String

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
                    .padding(.top, 149)
            }
            .ignoresSafeArea()

            VStack {
                HStack(spacing: 16) {
                    Image("LogoDefault")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 67, height: 67)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text(establishmentName)
                            .foregroundStyle(.white)
                            .font(.custom("Inter-Regular", size: 16))

                        Text("Bem-vindo, \(userName)")
                            .foregroundStyle(.white)
                            .font(.custom("Inter-Bold", size: 18))
                    }
                    .padding(.top, 8)
                    
                    Spacer()
                }
                .padding(.leading, 16)
                .padding(.top, 60)

                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    BackgroundHomeView(establishmentName: "Barbearia RockeFeller", userName: "Pedro Santos")
}
