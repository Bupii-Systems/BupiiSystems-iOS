//
//  SwiftUIView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 24/04/2025.
//

import SwiftUI

struct AlertView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 275)
                .cornerRadius(24)
                .zIndex(0)

            Text("Como deseja avançar?")
                .padding(.top, 63)
                .foregroundStyle(.black)
                .zIndex(1)
                .padding(.horizontal, 16)
                .font(.custom("Inter-Regular", size: 18))
            
            HStack {
                Spacer()
                Button(action: {
                    print("XClose button tapped!")
                }) {
                    Image("XClose")
                        .resizable()
                        .frame(width: 16.92, height: 16.92)
                }
                .padding(.top, 24)
                .padding(.trailing, 20) 
                .zIndex(2)
            }

            MainButton(buttonText: "Botão principal", action: {
                print("Principal")
            })
                .padding(.top, 124)
                .padding(.horizontal, 20)
            
            SecondaryButton(buttonText: "Botão secundário", action: {
                print("Secundário")
            })
                .padding(.top, 196)
                .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AlertView()
        .preferredColorScheme(.dark)
}
