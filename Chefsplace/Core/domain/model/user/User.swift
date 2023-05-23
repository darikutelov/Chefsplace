//
//  User.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import Foundation

struct User {
    let id: String?
    let uid: String
    let email: String
    let phoneNumber: String?
    let isAdmin: Bool?
    let cart: [OrderItem]?
    let orders: [Order]?
    let deliveryAddress: [Address]?
    let invoiceAddress: [Address]?
}
