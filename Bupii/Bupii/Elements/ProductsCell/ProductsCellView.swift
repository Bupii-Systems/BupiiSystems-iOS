//
//  ProductsCellView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 05/05/2025.
//

import SwiftUI

struct ProductsCellView: View {
    var productName: String
    var productDetail: String
    var price: String
    var imageName: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 134)
                .cornerRadius(24)
            
            HStack(alignment: .top) {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.top, 4)
                    .padding(.bottom, 4)
                    .padding(.leading, 16)
                
                VStack {
                    Text(productName)
                        .foregroundStyle(AppColor.text)
                        .font(.custom("Inter-Bold", size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(productDetail)
                        .foregroundStyle(AppColor.text)
                        .font(.custom("Inter-Regular", size: 14))
                        .padding(.top, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("R$ \(price)")
                        .foregroundStyle(AppColor.text)
                        .font(.custom("Inter-Bold", size: 18))
                        .padding(.top, 12)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.leading, 8)
                .padding(.trailing, 16)
                
                Spacer()
            }
        }
    }
}

