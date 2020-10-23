//
//  CreateProductView.swift
//  HelaBot SwiftUI
//
//  Created by Guido Gimeno on 22/10/2020.
//

import SwiftUI

struct CreateProductView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var fridge: FridgeViewModel
    @Binding var barCode: String
    @State var product = ""
    @State var category = GroceryCategory.other
    
    var body: some View {
        VStack {
            NavigationView {
                Form {
                    Section(header: Text("Barcode")) {
                        Text(barCode)
                    }
                    Section(header: Text("Product")) {
                        TextField("Product", text: $product)
                    }
                    Section(header: Text("Category")) {
                        Picker(selection: $category, label: Text("Category")) {
                            ForEach(GroceryCategory.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                    }
                }.navigationBarTitle("Create Product")
            }
            
            Button(action: {
                
                if self.barCode.isEmpty || self.product.isEmpty {
                    print("Empty fields remaining!")
                } else {
                    let product = GroceryProduct(barCode: UInt64(self.barCode)!, name: self.product, category: self.category)
                    self.fridge.add(groceryProduct: product)
                    self.isPresented = false
                }
                                        
            }, label: {
                Text("Add Product")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .padding(.all, 20)
                    .background(Color.green)
                    .cornerRadius(3)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            })
        }
    }
    
}
