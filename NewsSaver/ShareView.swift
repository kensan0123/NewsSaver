//
//  ShareView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/08.
//

import SwiftUI
import UniformTypeIdentifiers

struct ShareView: View {
    var context: NSExtensionContext?
    
    @State private var sharedURL: String? = nil
    
    var body: some View {
        Group {
            if let url = sharedURL {
                NewsSaveView(newsURL: url)
                    .modelContainer(for: NewsItem.self)
            } else {
                Text("共有URLを読み込み中...")
                    .onAppear() {
                        extructURL(from: context)
                    }
            }
        }
    }
    private func extructURL(from context: NSExtensionContext?) {
        guard let item = context?.inputItems.first as? NSExtensionItem else { return }
        
        for provider in item.attachments ?? [] {
            if provider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) {
                    data, _ in
                    if let url = data as? URL {
                        DispatchQueue.main.async {
                            self.sharedURL = url.absoluteString
                        }
                    }
                }
                return
            }
        }
    }
}

#Preview {
    ShareView()
}
