//
//  HomeView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 27/04/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
    
            Color((AppColor.grayBackground))
                .ignoresSafeArea()
            
            ScrollView {
                ZStack {
                    BackgroundHomeView(establishmentName: "BarbeariaRockeFeller", userName: "Larissa Souza")
                        .ignoresSafeArea()
                    
                    VStack {
                        Text("Conheça nossas unidades")
                            .foregroundStyle(Color(AppColor.text))
                            .font(.custom("Inter-Bold", size: 16))
                            .padding(.top, 200)
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        CellHomeEndUserView(imageName: "Barbershop1DefaultEU", address: "Casa do caralho porra merda aaa")
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

#Preview {
    HomeView()
}
