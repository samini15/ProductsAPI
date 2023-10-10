//
//  ProductDetailView.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: ProductEntity
    
    var body: some View {
        VStack(spacing: 0) {
            TabView {
                ForEach(product.images, id: \.self) { imageUrl in
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                    } placeholder: {
                        ProgressView {
                            Text("Please Wait...")
                        }
                    }
                }.ignoresSafeArea(.all, edges: .top)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .ignoresSafeArea(.all, edges: .top)
            
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Text(product.title)
                        .fontWeight(.semibold)
                        .font(.title2)
                        .padding()
                    TextWithRoundedRectangleOverlay(displayText: "\(String(product.price))$", color: .green)
                    
                    Spacer()
                    
                    Text(String(product.rating))
                    Image(systemName: "star.fill")
                        .padding(.trailing)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Text("Category:")
                            TextWithRoundedRectangleOverlay(displayText: product.category, color: .brown)
                            
                            Text("Brand:")
                            TextWithRoundedRectangleOverlay(displayText: product.brand, color: .cyan)
                            
                            Text("Discount:")
                            TextWithRoundedRectangleOverlay(displayText: "\(String(product.discountPercentage))%", color: .orange)
                            
                            Text("In stock:")
                            TextWithRoundedRectangleOverlay(displayText: String(product.stock), color: .mint)
                        }
                    }
                    Text(product.descriptionProperty)
                        .padding(.top, 10)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .blendMode(.hardLight)
                .cornerRadius(15)
                .shadow(radius: 10, x: 0, y: 10)
            }
        }
    }
}

#Preview {
    ProductDetailView(product: ProductEntity(id: 0, title: "Iphone 9", descriptionProperty: "An apple mobile which is nothing like apple", price: 549, discountPercentage: 5.0, rating: 3.0, stock: 4, brand: "Apple", category: "smartphones", thumbnail: URL(string: "https://i.dummyjson.com/data/products/1/thumbnail.jpg")!, images: [URL(string: "https://i.dummyjson.com/data/products/1/1.jpg")!, URL(string: "https://i.dummyjson.com/data/products/1/2.jpg")!, URL(string: "https://i.dummyjson.com/data/products/1/3.jpg")!]))
}
