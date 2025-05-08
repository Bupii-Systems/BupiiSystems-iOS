//
//  ProductGridView.swift
//  Bupii
//
//  Created by Pedro Ribeiro on 05/05/2025.
//

import SwiftUI

struct Product: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let detail: String
    let price: String
    let imageName: String
}

struct ProductGridView: View {
    let columns = [GridItem(.flexible())]
    
    @State private var products: [Product] = [
        Product(name: "Pomada Reuzel Azul", detail: "200 ml", price: "50", imageName: "ReuzelBlue"),
        Product(name: "Pomada Suavecito", detail: "150 ml", price: "45", imageName: "ReuzelBrow"),
        Product(name: "Pomada BlackFix", detail: "250 ml", price: "60", imageName: "ReuzelBrow")
    ]
    
    let timer = Timer.publish(every: 3.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(products) { product in
                    ProductsCellView(
                        productName: product.name,
                        productDetail: product.detail,
                        price: product.price,
                        imageName: product.imageName
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .onReceive(timer) { _ in
            withAnimation {
                let first = products.removeFirst()
                products.append(first)
            }
        }
    }
}

#Preview {
    ProductGridView()
        .preferredColorScheme(.dark)
}
