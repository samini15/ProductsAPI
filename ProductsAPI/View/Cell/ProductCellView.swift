//
//  ProductCellView.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import SwiftUI
import Kingfisher

struct ProductCellView: View {
    
    let product: ProductEntity
    
    var body: some View {
        HStack {
            KFImage(product.thumbnail)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .clipped()
                .shadow(color: .gray, radius: 3, x: 0, y: 0)
            
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.title2)
                
                
                TextWithRoundedRectangleOverlay(displayText: product.category, color: .brown)
                
                TextWithRoundedRectangleOverlay(displayText: "\((String(product.price)))$", color: .green)
            }
        }
    }
}

#Preview {
    ProductCellView(product: ProductEntity(id: 0, title: "Iphone 9", descriptionProperty: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 5.0, rating: 3.0, stock: 4, brand: "Apple", category: "smartphones", thumbnail: URL(string: "https://i.dummyjson.com/data/products/1/thumbnail.jpg")!, images: []))
}
