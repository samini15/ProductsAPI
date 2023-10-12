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
    @EnvironmentObject private var advanceFilterViewModel: AdvanceFilterViewModel
    
    @State private var searchQuery: String = ""
    @State private var openAdvanceFilterView = false
    
    @Query(sort: \ProductEntity.category) private var products: [ProductEntity]
    
    private var calculatedProducts: [String : [ProductEntity]] {
        let filteredProducts = advanceFilterViewModel.filterResult
        var productsByCategory: [String : [ProductEntity]]
        if filteredProducts.isEmpty {
            productsByCategory = viewModel.groupProductsByCategory(products: products)
        } else {
            productsByCategory = viewModel.groupProductsByCategory(products: filteredProducts)
        }
        
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
            .sheet(isPresented: $openAdvanceFilterView) {
                AdvanceFilterSheetView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        openAdvanceFilterView = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .refreshable {
                await fetchData(forceRefresh: true)
            }
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
        if products.isEmpty || forceRefresh {
            do {
                try await viewModel.fetchProducts(forceRefresh: forceRefresh)
            } catch {
                print(error.localizedDescription)
            }
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
        
        return viewModel.groupProductsByCategory(products: searchedItems)
    }
}

#Preview {
    ProductListView()
        .environmentObject(ProductViewModel(productService: ProductService()))
        .environmentObject(AdvanceFilterViewModel())
        .modelContainer(for: ProductEntity.self, inMemory: true)
}
