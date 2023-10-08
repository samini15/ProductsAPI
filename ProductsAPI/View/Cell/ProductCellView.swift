//
//  ProductCellView.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import SwiftUI

struct ProductCellView: View {
    
    let product: ProductDto
    
    var body: some View {
        HStack {
            AsyncImage(url: product.thumbnail) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    
                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.title2)
                
                HStack {
                    Text("\((String(product.price)))$")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.green.opacity(0.3))
                        }
                    
                    Text(product.category)
                        .padding(.horizontal, 7)
                        .padding(.vertical, 5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.brown.opacity(0.3))
                        }
                }
            }
        }
    }
}

#Preview {
    ProductCellView(product: ProductDto(id: 0, title: "Iphone 9", description: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 5.0, rating: 3.0, stock: 4, brand: "Apple", category: "smartphones", thumbnail: URL(string: "https://i.dummyjson.com/data/products/1/thumbnail.jpg")!, images: []))
}
