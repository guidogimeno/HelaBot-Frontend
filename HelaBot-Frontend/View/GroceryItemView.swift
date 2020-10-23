//
//  GroceryItemView.swift
//  HelaBot SwiftUI
//
//  Created by Guido Gimeno on 20/10/2020.
//

import SwiftUI

struct GroceryItemView: View {
    
    var groceryItem: GroceryItem
    var remove: (GroceryProduct) -> ()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(groceryItem.product.name)").fontWeight(.bold)
                Text("\(groceryItem.quantity)").fontWeight(.light)
            }.layoutPriority(1)
        }
        
        Spacer()
        
        Button(action: {
            self.remove(groceryItem.product)
        }, label: {
            Text("Remove")
                .foregroundColor(.white).fontWeight(.bold)
                .padding(.all, 12)
                .background(Color.red)
                .cornerRadius(3)
        })
    }
    
}
