//
//  ProductDto.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import Foundation

struct ProductResult: Codable {
    let products: [ProductDto]
}
struct ProductDto: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: URL
    let images: [URL]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
