//
//  GroceryProduct.swift
//  HelaBot SwiftUI
//
//  Created by Guido Gimeno on 04/10/2020.
//

import Foundation

struct GroceryProduct: Codable {
    let barCode: UInt64
    let name: String
    let category: GroceryCategory
}
