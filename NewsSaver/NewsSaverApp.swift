//
//  NewsSaverApp.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/03.
//

import SwiftUI
import SwiftData

@main
struct NewsSaverApp: App {
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore = false
    @Environment(\.modelContext) private var modelContext
    var body: some Scene {
        WindowGroup {
            if !hasLaunchedBefore {
                FirstIntroView()
            } else {
                ContentView()
                    .onAppear {
                        hasLaunchedBefore = true
                    }
            }
        }
        .modelContainer(for: NewsItem.self)
    }
    func migrateIfNeeded() async {
        do {
            var didMigrate = false
            let items = try modelContext.fetch(FetchDescriptor<NewsItem>())
            for item in items {
                if item.id == nil {
                    item.id = UUID()
                    didMigrate = true
                }
            }
            if didMigrate {
                try modelContext.save()
                print("UUID migration completed.")
            }
        } catch {
            print("Migration failed: \(error)")
        }
    }
}
