//
//  Product.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 19.05.23.
//

import Foundation

struct Product: Hashable, Identifiable, Codable {
    let id: String
    let name: String
    let images: [String]
    let price: Decimal
    let reducedPrice: Decimal
    let shortDescription: String
    let category: ProductCategory
    let onPromotion: Bool?
    let barCode: String?
    let productCode: String?
    let weight: Double
}

/// Conform to hashable
extension Product {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct ProductDescription: Codable {
    let content: String
    let ingredients: String
    let advantages: String
    let storage: String
    let nutritionalValues: NutritionalValue
}

struct NutritionalValue: Identifiable, Codable {
    var id: String {
        return label
    }
    
    let label: String
    let text: String
}

