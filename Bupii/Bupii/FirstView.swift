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
        !(selectedTab == 1 && shouldNavigateToBooking)
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

            BookingView(selectedTab: $selectedTab)
                .tag(1)
                .tabItem { EmptyView() }
            
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

#Preview {
    ContentView()
}
