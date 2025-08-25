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
        extractURL(from: extensionContext) { [weak self] url in
            DispatchQueue.main.async {
                self?.rootView = NewsSaveView(
                    newsURL: url ?? "",
                    extensionContext: self?.extensionContext
                )
            }
        }
    }

    private func extractURL(from context: NSExtensionContext?, completion: @escaping (String?) -> Void) {
        guard let items = context?.inputItems as? [NSExtensionItem] else {
            completion(nil)
            return
        }

        for item in items {
            guard let providers = item.attachments else { continue }

            if let urlProvider = providers.first(where: { $0.hasItemConformingToTypeIdentifier(UTType.url.identifier) }) {
                urlProvider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) { value, error in
                    if let error = error {
                        print("❌ URL取得エラー: \(error)")
                        completion(nil)
                        return
                    }

                    if let url = value as? URL {
                        completion(url.absoluteString)
                    } else if let str = value as? String, let url = URL(string: str) {
                        completion(url.absoluteString)
                    } else if let data = value as? Data,
                              let str = String(data: data, encoding: .utf8),
                              let url = URL(string: str) {
                        completion(url.absoluteString)
                    } else {
                        print("❓ URLを解釈できませんでした: \(String(describing: value))")
                        completion(nil)
                    }
                }
                return
            }
        }

        completion(nil)
    }
}
