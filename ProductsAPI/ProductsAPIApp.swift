//
//  ProductsAPIApp.swift
//  ProductsAPI
//
//  Created by Shayan Amini on 08/10/2023.
//

import SwiftUI
import SwiftData

@main
struct ProductsAPIApp: App {
    @StateObject var productViewModel: ProductViewModel = ProductViewModel(productService: ProductService())
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ProductListView()
                .environmentObject(ProductViewModel(productService: ProductService()))
        }
        .modelContainer(sharedModelContainer)
    }
}
