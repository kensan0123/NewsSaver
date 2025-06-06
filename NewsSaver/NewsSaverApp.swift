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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: NewsItem.self)
    }
}
