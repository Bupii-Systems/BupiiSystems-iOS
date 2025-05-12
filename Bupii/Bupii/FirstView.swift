//
//  ContentView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 22/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Int = 0
    @State private var shouldNavigateToBooking: Bool = false
    var shouldShowTabBar: Bool {
        !shouldNavigateToBooking
    }
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(
                shouldNavigateToBooking: $shouldNavigateToBooking,
                tabSelection: $selectedTab
            )
            .tag(0)
            .tabItem { EmptyView() }
            
            TeamView()
                .tag(1)
                .tabItem { EmptyView() }
            
            MyAgendaView()
                .tag(2)
                .tabItem { EmptyView() }
            
            ProfileAndSettingsView()
                .tag(3)
                .tabItem { EmptyView() }
            
        }
        .fullScreenCover(isPresented: $shouldNavigateToBooking) {
            BookingView(
                shouldNavigateToBooking: $shouldNavigateToBooking,
                selectedTab: $selectedTab
            )
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .overlay(
            VStack {
                Spacer()
                if shouldShowTabBar {
                    TabBarView(selectedTab: $selectedTab)
                        .frame(height: 70)
                        .padding(.horizontal, 16)
                        .cornerRadius(40)
                        .shadow(color: Color.gray.opacity(0.7), radius: 10, x: 0, y: -2)
                        .padding(.bottom, 8)
                }
            }
        )
        
    }
}

#Preview {
    ContentView()
}

