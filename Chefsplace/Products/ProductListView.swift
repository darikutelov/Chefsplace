//
//  ProductListView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 6.07.23.
//

import SwiftUI

struct ProductListView: View {
    @Bindable private var viewModel: ProductViewViewModel = .init()
    
    var body: some View {
        NavigationStack {
            LazyVStack {
                ForEach($viewModel.products) { product in
                    ProductListCard(product: product)
                }
            }
        }
        .task {
            // Fetch initial products
            await viewModel.fetchProducts()
        }
    }
}

#Preview {
    ProductListView()
}
