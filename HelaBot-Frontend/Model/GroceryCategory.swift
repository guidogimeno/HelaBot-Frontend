//
//  GroceryCategory.swift
//  HelaBot SwiftUI
//
//  Created by Guido Gimeno on 04/10/2020.
//

import Foundation

enum GroceryCategory: String, CaseIterable {
    case dairy = "DAIRY"
    case bread = "BREAD"
    case drink = "DRINK"
    case other = "OTHER"
}

extension GroceryCategory: Codable {
    init(from decoder: Decoder) throws {
        guard let value = try? decoder.singleValueContainer().decode(String.self) else {
            self = .other
            return
        }
        self = GroceryCategory(rawValue: value) ?? .other
    }
}
