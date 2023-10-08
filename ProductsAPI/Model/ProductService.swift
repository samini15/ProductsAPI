//
//  ProductService.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts() async throws -> NetworkResult<ProductResult>
}

struct ProductService: ProductServiceProtocol {
    
    private let url: URL? = URL(string: "https://dummyjson.com/products")
    
    
    func fetchProducts() async throws -> NetworkResult<ProductResult> {
        guard let url else { return NetworkResult.failure(NetworkError.badUrl) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return NetworkResult.failure(NetworkError.badResponse) }
        
        let jsonDecoder = JSONDecoder()
        
        let decodedData = try jsonDecoder.decode(ProductResult.self, from: data)
        return NetworkResult.success(decodedData)
    }
}
