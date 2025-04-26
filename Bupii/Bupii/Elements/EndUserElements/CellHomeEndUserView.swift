//
//  CellHomeEndUserView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 26/04/2025.
//

import SwiftUI

struct CellHomeEndUserView: View {
    
    let imageName: String
    let address: String
    
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
                    
                    Rectangle()
                        .frame(height: 149)
                        .padding(.horizontal, 0)
                        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                        .padding(.horizontal, 16)
                        .padding(.top, 380)
                }
            }
            
            //ex: how to use color with a svg image
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
                .padding(.bottom, 92)
                .padding(.top, 400)
            
            MainButton(buttonText: "Agendar atendimento", action: {
                print("tapped")
            })
            .padding(.bottom, 28)
            .padding(.horizontal, 18)
            
        }
    }
}

#Preview {
    CellHomeEndUserView(
        imageName: "Barbershop1DefaultEU",
        address: "Rua João de Barro, 421 Lapa | São Paulo"
    )
    .preferredColorScheme(.dark)
}





