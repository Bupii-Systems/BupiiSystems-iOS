//
//  HomeView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 27/04/2025.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @Binding var shouldNavigateToBooking: Bool
    @Binding var tabSelection: Int
    
    let name = Auth.auth().currentUser?.displayName
    
    var body: some View {
        ZStack {
            
            Color((AppColor.grayBackground))
                .ignoresSafeArea()
            
            ScrollView {
                ZStack {
                    BackgroundHomeView(establishmentName: "BarbeariaRockeFeller", userName: name ?? "")
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
                                tabSelection = 1
                            }
                        )
                            .padding(.top, -48)
                        
                        Spacer()
                    }
                    .padding(.bottom, 120)
                }
                .ignoresSafeArea()
            }
            .ignoresSafeArea()
        }
    }
}

//#Preview {
//    HomeView()
//}
