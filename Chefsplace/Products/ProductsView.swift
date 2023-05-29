//
//  ProductsView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI

struct ProductsView: View {
    var body: some View {
        Text("Products")
            .modifier(Heading())
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
