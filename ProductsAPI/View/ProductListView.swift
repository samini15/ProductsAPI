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
    
    @Query(sort: \ProductEntity.category) private var products: [ProductEntity]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewModel.productResult?.products ?? []) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductCellView(product: product)
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
}

#Preview {
    ProductListView()
        .environmentObject(ProductViewModel(productService: ProductService()))
        .modelContainer(for: ProductEntity.self, inMemory: true)
}
