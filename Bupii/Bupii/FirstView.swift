//
//  ContentView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 22/04/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView {
                HomeView()
                    .tabItem {
                        EmptyView()
                    }
                
                Text("Another screen")
                    .tabItem {
                        EmptyView()
                    }
            }
            .overlay(
                TabBarView()
                    .frame(maxWidth: .infinity, maxHeight: 70)
                    .padding(.horizontal, 16)
                    .offset(y: -32)
                    .background(Color.clear)
                    .background(Color(AppColor.grayBackground))
                    .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: -2),
                alignment: .bottom
            )
            .edgesIgnoringSafeArea(.bottom)
        }
    }

#Preview {
    ContentView()
}
