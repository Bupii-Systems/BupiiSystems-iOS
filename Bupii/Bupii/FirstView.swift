//
//  ContentView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 22/04/2025.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        VStack {
            Button(action: {
                print("Botão pressionado!")
            }) {
                Text("Clique aqui")
                
                    .padding()
                    .background(Color(AppColor.brand))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .font(.custom("Inter-Bold", size: 16))
                    
            }
            
        }
        
    }
}

#Preview {
    FirstView()
}
