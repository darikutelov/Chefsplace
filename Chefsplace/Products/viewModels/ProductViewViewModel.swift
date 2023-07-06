//
//  ProductViewViewModel.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 6.07.23.
//

import SwiftUI
import Observation

@Observable
final class ProductViewViewModel {
    private let requestManager = RequestManager()
    
    // Main Actor props
    @MainActor var products: [Product] = []
    @MainActor var isLoading: Bool = false
    @MainActor var errorMessage: String = ""
}

// MARK: - Fetch Products
extension ProductViewViewModel {
    
    @MainActor
    func fetchProducts() async {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        do {
            // TODO: - Remove page and limit after implementing SwiftData
            let data: ProductsContainer = try await requestManager
                .perform(ProductsRequest.getAllProducts(
                    page: 1,
                    limit: 10)
                )
            products.append(contentsOf: data.products)
        } catch {
            errorMessage = error.localizedDescription
            print(error.localizedDescription)
        }
    }

}
