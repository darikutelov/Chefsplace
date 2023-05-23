//
//  DeliveryAddress.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import Foundation

struct Address {
    let id: String
    let name: String
    let firstName: String
    let lastName: String
    let company: String?
    let eik: String?
    let vatNumber: String?
    let mol: String?
    let phoneNumber: String
    let city: String
    let postCode: String?
    let addressLine: String
    let addressLine2: String
    let note: String
    let isDefault: Bool
}
