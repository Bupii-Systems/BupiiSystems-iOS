//
//  TabBarView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 24/04/2025.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 70)
                .cornerRadius(40)
                .zIndex(0)

            HStack {
                Spacer()
                Circle()
                    .foregroundColor(selectedTab == 0 ? Color(AppColor.brand).opacity(0.2) : Color(AppColor.lightGray))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Button(action: {
                            withAnimation {
                                selectedTab = 0
                            }
                        }) {
                            Image(selectedTab == 0 ? "StoreColor" : "Store")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    )
                Spacer()

                Circle()
                    .foregroundColor(selectedTab == 1 ? Color(AppColor.brand).opacity(0.2) : Color(AppColor.lightGray))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Button(action: {
                            withAnimation {
                                selectedTab = 1
                            }
                        }) {
                            Image(selectedTab == 1 ? "ScissorColor" : "Scissor")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    )
                Spacer()

                Circle()
                    .foregroundColor(selectedTab == 2 ? Color(AppColor.brand).opacity(0.2) : Color(AppColor.lightGray))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Button(action: {
                            withAnimation {
                                selectedTab = 2
                            }
                        }) {
                            Image(selectedTab == 2 ? "CalendarColor" : "Calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    )
                Spacer()

                Circle()
                    .foregroundColor(selectedTab == 3 ? Color(AppColor.brand).opacity(0.2) : Color(AppColor.lightGray))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Button(action: {
                            withAnimation {
                                selectedTab = 3
                            }
                        }) {
                            Image(selectedTab == 3 ? "PersonColor" : "Person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    )
                Spacer()
            }
        }
    }
}

#Preview {
    TabBarView(selectedTab: .constant(0))
        .preferredColorScheme(.dark)
}

//#Preview {
//    TabBarView()
//        .preferredColorScheme(.dark)
//}
