//
//  ProductEntity.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import Foundation
import SwiftData

@Model
final class ProductEntity {
    @Attribute(.unique) let id: Int
    let title: String
    let descriptionProperty: String // SwiftData does not allow to use the name description
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: URL
    let images: [URL]
    
    init(id: Int, title: String, descriptionProperty: String, price: Int, discountPercentage: Double, rating: Double, stock: Int, brand: String, category: String, thumbnail: URL, images: [URL]) {
        self.id = id
        self.title = title
        self.descriptionProperty = descriptionProperty
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
}
