//
//  snk_collectionApp.swift
//  snk_collection
//
//  Created by Franklin Carvalho on 21/06/24.
//

import SwiftUI
import SwiftData

@main
struct snk_collectionApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ItemModel.self,
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
            SplashView()
        }
        
        .modelContainer(sharedModelContainer)
    }
}
