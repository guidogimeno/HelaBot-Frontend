//
//  GroceryItem.swift
//  HelaBot SwiftUI
//
//  Created by Guido Gimeno on 04/10/2020.
//

import Foundation

struct GroceryItem: Codable {
    let product: GroceryProduct
    let quantity: Int
}

extension GroceryItem: Identifiable {
    var id: UUID? { return UUID() }
}
