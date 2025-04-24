//
//  TabBarView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 24/04/2025.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedButton: Int? = nil
    
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
                    .foregroundColor(self.selectedButton == 1 ? Color(AppColor.brand).opacity(0.2) : Color(AppColor.lightGray))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Button(action: {
                            withAnimation {
                                self.selectedButton = self.selectedButton == 1 ? nil : 1
                            }
                        }) {
                            Image(self.selectedButton == 1 ? "StoreColor" : "Store")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    )
                Spacer()

                Circle()
                    .foregroundColor(self.selectedButton == 2 ? Color(AppColor.brand).opacity(0.2) : Color(AppColor.lightGray))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Button(action: {
                            withAnimation {
                                self.selectedButton = self.selectedButton == 2 ? nil : 2
                            }
                        }) {
                            Image(self.selectedButton == 2 ? "ScissorColor" : "Scissor")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    )
                Spacer()

                Circle()
                    .foregroundColor(self.selectedButton == 3 ? Color(AppColor.brand).opacity(0.2) : Color(AppColor.lightGray))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Button(action: {
                            withAnimation {
                                self.selectedButton = self.selectedButton == 3 ? nil : 3
                            }
                        }) {
                            Image(self.selectedButton == 3 ? "CalendarColor" : "Calendar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    )
                Spacer()

                Circle()
                    .foregroundColor(self.selectedButton == 4 ? Color(AppColor.brand).opacity(0.2) : Color(AppColor.lightGray))
                    .frame(width: 50, height: 50)
                    .overlay(
                        Button(action: {
                            withAnimation {
                                self.selectedButton = self.selectedButton == 4 ? nil : 4
                            }
                        }) {
                            Image(self.selectedButton == 4 ? "PersonColor" : "Person") 
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
    TabBarView()
        .preferredColorScheme(.dark)
}
