//
//  CellHomeEndUserView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/04/2025.
//

import SwiftUI
import FirebaseAuth

struct CellHomeEndUserView: View {
    
    let imageName: String
    let address: String
    let onBookingTap: () -> Void
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                ZStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 394)
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                        .padding(.horizontal, 16)
                        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 5, y: 5)
                    
                    Rectangle()
                        .foregroundStyle(.white)
                        .frame(height: 149)
                        .padding(.horizontal, 0)
                        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                        .padding(.horizontal, 16)
                        .padding(.top, 380)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
            }
            
            Image("LocationColor")
                .renderingMode(.template)
                .resizable()
                .frame(width: 29, height: 29)
                .padding(.leading, 40)
                .padding(.bottom, 96)
                .foregroundStyle(Color(AppColor.brand))
            
            Text(truncate(address, limit: 52))
                .font(.custom("Inter-Regular", size: 16))
                .foregroundStyle(Color(AppColor.text))
                .padding(.leading, 74)
                .padding(.trailing, 74)
                .padding(.bottom, address.count < 32 ? 102 : 92)
            
            MainButton(buttonText: "Agendar atendimento", action: {
                onBookingTap()
            })
            .padding(.bottom, 28)
            .padding(.horizontal, 18)
        }
    }
}

//#Preview {
//    CellHomeEndUserView(
//        imageName: "Barbershop1DefaultEU",
//        address: "Rua João de Barro, 421 Lapa | São Paulo"
//    )
//    .preferredColorScheme(.dark)
//}
