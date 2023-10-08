//
//  ProductViewModel.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import Foundation
import OSLog
import SwiftData

@MainActor
class ProductViewModel: ObservableObject {
    
    private let logger = Logger(subsystem: bundleIdentifier, category: "ProductViewModel")
    
    private let productService: ProductServiceProtocol
    
    var modelContext: ModelContext?
    
    @Published public private(set) var fetchingProducts = false
    @Published public private(set) var fetchFailedWithError: Error?
    @Published public private(set) var productResult: ProductResult?
    
    init(productService: ProductServiceProtocol) {
        self.productService = productService
    }
    
    func fetchProducts() async throws {
        
        fetchingProducts = true
        
        do {
            let result = try await productService.fetchProducts()
            
            switch result {
            case .success(let data):
                productResult = data
                fetchingProducts = false
            case .failure(let error):
                fetchFailedWithError = error
                fetchingProducts = false
                logger.error("\(error.localizedDescription)")
            }
        }
    }
    
    func offlineCacheProducts() {
        guard let modelContext else {return}
        productResult?.products.forEach { product in
            let product = ProductEntity(id: product.id, title: product.title, descriptionProperty: product.description, price: product.price, discountPercentage: product.discountPercentage, rating: product.rating, stock: product.stock, brand: product.brand, category: product.category, thumbnail: product.thumbnail, images: product.images)
            
            modelContext.insert(product)
        }
    }
}
