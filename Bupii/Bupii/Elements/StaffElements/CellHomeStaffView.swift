//
//  CellHomeStaffView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 25/04/2025.
//

import SwiftUI

//MARK: Background to build
struct CellHomeStaffView: View {
    let imageName: String
    let address: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                ZStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 358, height: 252)
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                        .padding(.horizontal, 16)

                    Rectangle()
                        .frame(width: 358, height: 78)
                        .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
                        .padding(.horizontal, 16)
                        .padding(.top, 280)
                }
            }
            
            //ex: how to use color with a svg image
            Image("LocationColor")
                .renderingMode(.template)
                .resizable()
                .frame(width: 29, height: 29)
                .padding(.leading, 40)
                .padding(.bottom, 30)
                .foregroundStyle(Color(AppColor.brand))

            Text(address)
                .font(.custom("Inter-Regular", size: 16))
                .foregroundStyle(Color(AppColor.text))
                .padding(.leading, 100)
                .padding(.trailing, 100)
                .padding(.bottom, address.count > 25 ? 24 : 40)
        }
    }
}

#Preview {
    CellHomeStaffView(
        imageName: "Barbershop1Default",
        address: "Rua João de Barro, 421 Lapa | São Paulo"
    )
    .preferredColorScheme(.dark)
}





