//
//  Order.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import Foundation

struct Order {
    let id: String
    let orderNumber: Int
    let created: Date
    let orderItem: [OrderItem]
    let deliveryCharge: Decimal
    let deliveryAddress: Address
    let invoiceAddresss: Address
    let payment: PaymentTypes
    let status: OrderStatus
}

enum PaymentTypes {
    case COD
    case BankPayment
    case CardPayment
    case Other
}

enum OrderStatus: String {
    case PENDING
    case CONFIRMED
    case AWAITINGPAYMENT = "Awaiting Payment"
    case COMPLETED
    case CANCELLED
}

struct OrderItem {
    let id: String
    let name: String
    let image: String
    let price: Decimal
    let quantity: UInt8
    let weight: Float
}
