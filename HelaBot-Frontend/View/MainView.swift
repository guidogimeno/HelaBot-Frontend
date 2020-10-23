//
//  ContentView.swift
//  HelaBot SwiftUI
//
//  Created by Guido Gimeno on 04/10/2020.
//

import SwiftUI

struct MainView: View {
    
    @State private var isShowingScanner = false
    @ObservedObject var fridge = FridgeViewModel()
    
    var body: some View {
        VStack {
            NavigationView {
                List(fridge.getGroceryItems()) { groceryItem in
                    GroceryItemView(groceryItem: groceryItem, remove: { product in
                        fridge.remove(groceryProduct: product)
                    })
                }.navigationTitle("Fridge")
            }
            
            Button(action: {
                self.isShowingScanner = true
            }, label: {
                Text("Add")
                    .foregroundColor(.white)
                    .font(.system(size: 30))
                    .padding(.all, 20)
                    .background(Color.green)
                    .cornerRadius(3)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }).sheet(isPresented: $isShowingScanner) {
                AddView(isPresented: $isShowingScanner, fridge: fridge)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
