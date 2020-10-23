//
//  Path.swift
//  HelaBot SwiftUI
//
//  Created by Guido Gimeno on 22/10/2020.
//

let baseURL = "http://192.168.0.16:8090"

struct Path {
    
    struct Fridge {
        
        var get: String { return "\(baseURL)/fridge/1" }
        
        var products: String { return "\(baseURL)/fridge/1/grocery_product" }
        
    }
    
    struct Product {
        
        var get: (String) -> String = { barCode in
            return "\(baseURL)/grocery_product/\(barCode))"
        }
        
    }
    
}
