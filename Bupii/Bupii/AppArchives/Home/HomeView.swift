//
//  HomeView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 27/04/2025.
//

import SwiftUI

struct HomeView: View {
    @Binding var shouldNavigateToBooking: Bool
    @Binding var tabSelection: Int

    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            Color(AppColor.grayBackground)
                .ignoresSafeArea()

            ScrollView {
                ZStack {
                    BackgroundHomeView(establishmentName: viewModel.establishmentName, userName: viewModel.userName)
                        .ignoresSafeArea()

                    VStack {
                        Text("Conheça nossas unidades")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 16))
                            .padding(.top, 200)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        CellHomeEndUserView(
                            imageName: "Barbershop1DefaultEU",
                            address: "Casa 2, São Paulo.",
                            onBookingTap: {
                                shouldNavigateToBooking = true
                            }
                        )
                        .padding(.top, -48)

                        Spacer()
                    }
                    .padding(.bottom, 120)
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

//#Preview {
//    HomeView()
//}
