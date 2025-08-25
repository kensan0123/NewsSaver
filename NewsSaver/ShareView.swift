//
//  ShareView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/08.
//

import SwiftUI
import UniformTypeIdentifiers

struct ShareView: View {
    var newsURL: String
    var context: NSExtensionContext?

    var body: some View {
        NewsSaveView(newsURL: newsURL, extensionContext: context)
            .modelContainer(for: NewsItem.self)
    }
}
