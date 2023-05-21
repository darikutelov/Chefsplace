//
//  ProductRequest.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 21.05.23.
//

import Foundation

enum ProductsRequest: RequestProtocol {
    case getAllProducts(page: Int, limit: Int)
    
    var path: String {
        "/api/v1/products"
    }
    
    var urlParams: [String: String?] {
        switch self {
        case let .getAllProducts(page, limit):
            return ["page": String(page), "limit": String(limit)]
        }
    }
    
    var addAuthorizationToken: Bool {
        switch self {
        case .getAllProducts:
            return false
        }
    }
    
    var requestType: RequestType {
        .GET
    }
}
