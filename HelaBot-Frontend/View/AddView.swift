//
//  AddView.swift
//  HelaBot SwiftUI
//
//  Created by Guido Gimeno on 20/10/2020.
//

import SwiftUI

struct AddView: View {
    
    @State var unknownProduct: Bool = false
    @Binding var isPresented: Bool
    @ObservedObject var fridge: FridgeViewModel
    @State var barCode = ""
    
    var body: some View {
        VStack {
            if unknownProduct {
                CreateProductView(isPresented: $isPresented, fridge: fridge, barCode: $barCode)
            } else {
                CodeScannerView(codeTypes: [.ean8, .ean13, .pdf417], completion: self.handleScan)
            }
        }
    }
}

extension AddView {
    
    private func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        switch result {
        case .success(let barCode):
            getProduct(barCode: barCode)
        case .failure(let error):
            print("Scanning failed \(error)")
        }
    }
    
    private func getProduct(barCode: String) {
        let apiManager = APIManager.sharedInstance
        apiManager.get(endPoint: "/grocery_product/\(barCode)") { (result: Result<GroceryProduct, HttpError>) in
            switch result {
            case .success(let product):
                self.fridge.add(groceryProduct: product)
                self.isPresented = false
            case.failure(let error):
                print(error)
                self.unknownProduct = true
                self.barCode = barCode
            }
        }
    }
}
    
