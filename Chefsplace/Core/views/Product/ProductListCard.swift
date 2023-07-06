//
//  ListingProductCardView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 14.06.23.
//

import SwiftUI

struct ProductListCard: View {
    @Binding var product: Product
    
    var body: some View {
        VStack {
            Text(product.name.uppercased())
        }
        .frame(minHeight: 400)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.secondary.opacity(0.05))
        )
    }
}

#Preview {
    ProductListCard(
        product: .constant(
            Product(id: "1",
                    name: "Test",
                    images: [""],
                    category: .init(id: "1", name: "Test Category", imageUrl: "", position: 1),
                    price: 10.14,
                    reducedPrice: 10.0,
                    shortDescription: "",
                    onPromotion: false,
                    barCode: "123",
                    productCode: "123",
                    weight: 1
                   )
        )
    )
}
