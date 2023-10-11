//
//  AdvanceFilterViewModel.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 10/10/2023.
//

import Foundation
import SwiftData

@MainActor
class AdvanceFilterViewModel: ObservableObject {
    
    var allProducts: [ProductEntity] = []
    
    @Published public private(set) var filterResult: [ProductEntity] = []
    
    func applyFilter(price: Int, category: String, brand: String, rating: String) {
        filterResult = allProducts.filter {
            $0.price <= price &&
            ($0.category == category || $0.brand == brand) &&
            $0.rating <= Double(rating) ?? 5.0
        }
    }
    
    func initializeFilter() {
        filterResult = []
    }
    
    
}
