//
//  Pagination.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 21.05.23.
//

import Foundation

struct Pagination: Codable {
  let countPerPage: Int
  let totalCount: Int
  let currentPage: Int
  let totalPages: Int
}
