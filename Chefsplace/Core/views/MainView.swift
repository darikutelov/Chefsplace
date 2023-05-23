//
//  ContentView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 19.05.23.
//

import SwiftUI

struct MainView: View {
    private let requestManager = RequestManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
//        .task {
//            await fetchCategories()
//            await fetchProducts()
//        }
    }
    
    private func fetchCategories() async {
        do {
            let categories: ProductCategoriesContainer = try await requestManager
                .perform(CategoriesRequest.getAllCategories)
            
            print(categories)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchProducts() async {
        do {
            let products: ProductsContainer = try await requestManager
                .perform(ProductsRequest.getAllProducts(page: 1, limit: 2))
            
            print(products)
        } catch {
            print(error.localizedDescription)
        }
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
