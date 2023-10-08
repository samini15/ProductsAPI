//
//  ContentView.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import SwiftUI
import SwiftData

struct ProductListView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var viewModel: ProductViewModel
    
    @State private var searchQuery: String = ""
    
    @Query(sort: \ProductEntity.category) private var products: [ProductEntity]
    
    private var calculatedProducts: [String : [ProductEntity]] {
        
        let productsByCategory = groupProductsByCategory(products: products)
        
        if searchQuery.isEmpty {
            return productsByCategory
        }
        let searchResult = searchProducts(products: productsByCategory)
        
        return searchResult
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(Array(calculatedProducts.keys), id: \.self) { category in
                    Section(header: Text(category).font(.headline)) {
                        ForEach(calculatedProducts[category] ?? []) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                ProductCellView(product: product)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Products")
        } detail: {
            Text("Select an item")
        }
        .task {
            await fetchData(forceRefresh: false)
        }
        .searchable(text: $searchQuery, prompt: "Search Products")
    }
    
    private func fetchData(forceRefresh: Bool) async {
        viewModel.modelContext = modelContext
        if products.isEmpty {
            do {
                try await viewModel.fetchProducts()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func groupProductsByCategory(products: [ProductEntity]) -> [String : [ProductEntity]] {
        return Dictionary(grouping: products) { prod in
            prod.category
        }
    }
    
    private func searchProducts(products: [String : [ProductEntity]]) -> [String : [ProductEntity]] {
        var searchedItems: [ProductEntity] = []
        products.forEach { (key: String, value: [ProductEntity]) in
            let products = value.compactMap { product in
                let titleContainsQuery = product.title.contains(searchQuery)
                return titleContainsQuery ? product : nil
            }
            searchedItems.append(contentsOf: products)
        }
        
        return groupProductsByCategory(products: searchedItems)
    }
}

#Preview {
    ProductListView()
        .environmentObject(ProductViewModel(productService: ProductService()))
        .modelContainer(for: ProductEntity.self, inMemory: true)
}
