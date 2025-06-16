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
}
