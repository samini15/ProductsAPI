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
    
    //@Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewModel.productResult?.products ?? []) { product in
                    NavigationLink {
                        Text(product.title)
                    } label: {
                        Text(product.title)
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .task {
            await fetchData(forceRefresh: false)
        }
    }
    
    private func fetchData(forceRefresh: Bool) async {
        do {
            try await viewModel.fetchProducts()
        } catch {
            print(error.localizedDescription)
        }
    }

    /*private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }*/
}

#Preview {
    ProductListView()
        .environmentObject(ProductViewModel(productService: ProductService()))
        .modelContainer(for: Item.self, inMemory: true)
}
