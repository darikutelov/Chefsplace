//
//  Category.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 19.05.23.
//

import Foundation

struct ProductCategory: Identifiable, Codable {
    let id: String
    let name: String
    let imageUrl: String
    let position: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, imageUrl, position
    }
}

struct ProductCategoriesContainer: Decodable {
    let categories: [ProductCategory]
}
