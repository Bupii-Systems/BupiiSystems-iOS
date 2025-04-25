//
//  GenericDropDown.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 25/04/2025.
//

import SwiftUI

struct GenericDropDown: View {
    @State private var text = ""
    @State private var isExpanded = false
    var leftImageName: String
    var options: [String]
    var placeholder: String

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(self.isExpanded ? Color(AppColor.brand).opacity(0.2) : .white)
                    .frame(height: 56)
                    .cornerRadius(8)
                    .zIndex(0)

                HStack {
                    Image(leftImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 16)

                    ZStack {
                        if text.isEmpty {
                            Text(placeholder)
                                .foregroundColor(Color(AppColor.text))
                                .font(.custom("Inter-Regular", size: 16))
                                .padding(.leading, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        Text(text)
                            .padding(10)
                            .background(Color.clear)
                            .cornerRadius(8)
                            .font(.custom("Inter-Regular", size: 16))
                            .foregroundColor(Color(AppColor.text))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Image("ArrowDown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 16)
                        .padding(.bottom, 10)
                        .onTapGesture {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }
                }
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                .zIndex(1)
            }

            if isExpanded {
                VStack {
                    ForEach(options, id: \.self) { option in
                        Text(option)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .foregroundColor(Color(AppColor.text))
                            .onTapGesture {
                                text = option
                                withAnimation {
                                    isExpanded = false
                                }
                            }
                    }
                }
                .background(Color.white)
                .cornerRadius(8)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    GenericDropDown(leftImageName: "LockColor", options: ["Limited Access", "Full Access", "Restricted Access"], placeholder: "Escolha a opção")
        .preferredColorScheme(.dark)
}
