//
//  ContentView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 19.05.23.
//

import SwiftUI

struct ContentView: View {
    private let requestManager = RequestManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .task {
            await fetchCategories()
        }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
