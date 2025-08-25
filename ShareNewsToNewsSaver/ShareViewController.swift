//
//  ShareViewController.swift
//  ShareNewsToNewsSaver
//
//  Created by 中村健介 on 2025/06/07.
//

import SwiftUI
import UniformTypeIdentifiers

class ShareViewController: UIHostingController<NewsSaveView> {
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: NewsSaveView(newsURL: "", extensionContext: nil))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        printSharedURL(from: extensionContext)
        rootView = NewsSaveView(newsURL: "", extensionContext: nil)
    }
    private func printSharedURL(from context: NSExtensionContext?) {
        guard let items = context?.inputItems as? [NSExtensionItem] else { return }

        for item in items {
            guard let providers = item.attachments else { continue }

            // public.url を探す
            if let urlProvider = providers.first(where: { $0.hasItemConformingToTypeIdentifier(UTType.url.identifier) }) {
                urlProvider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) { (value, error) in
                    if let error = error {
                        print("❌ URL取得エラー: \(error)")
                        return
                    }
                    if let url = value as? URL {
                        print("✅ 共有されたURL:", url.absoluteString)
                    } else if let data = value as? Data,
                              let str = String(data: data, encoding: .utf8) {
                        print("⚠️ Dataとして取得:", str)
                    } else {
                        print("❓ URLを解釈できませんでした: \(String(describing: value))")
                    }
                }
            }
        }
    }
}
