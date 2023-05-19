//
//  ProtocolRequest.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 19.05.23.
//

import Foundation

enum CategoriesRequest: RequestProtocol {
    case getAllCategories
    
    var path: String {
        "/api/v1/categories"
    }
    
    var requestType: RequestType {
      .GET
    }
}
