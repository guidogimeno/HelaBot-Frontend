//
//  FridgeViewModel.swift
//  HelaBot SwiftUI
//
//  Created by Guido Gimeno on 20/10/2020.
//

import Foundation

class FridgeViewModel: ObservableObject {
    
    @Published var fridge: Fridge?
    
    let apiManager = APIManager.sharedInstance
    
    init() {
        print("Fetching...")
        fetchFridge()
    }
    
    private func fetchFridge() {
        apiManager.get(endPoint: "/fridge/1") { (result: Result<Fridge, HttpError>) in
            self.updateFridge(result)
        }
    }
    
    func remove(groceryProduct: GroceryProduct) {
        apiManager.delete(endPoint: "/fridge/1/grocery_product", object: groceryProduct) { (result: Result<Fridge, HttpError>) in
            self.updateFridge(result)
        }
    }
    
    func add(groceryProduct: GroceryProduct) {
        apiManager.post(endPoint: "/fridge/1/grocery_product", object: groceryProduct) { (result: Result<Fridge, HttpError>) in
            self.updateFridge(result)
        }
    }
    
    private func updateFridge(_ result: Result<Fridge, HttpError>) {
        switch result {
        case .success(let fridge):
            self.fridge = fridge
        case.failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    func getGroceryItems() -> [GroceryItem] {
        return fridge?.groceryItems ?? []
    }
}
