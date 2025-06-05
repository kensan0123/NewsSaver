//
//  NewsURLHandle.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/05.
//

import Foundation
import LinkPresentation
import UIKit

struct PreviewInfo {
    let title: String?
    let thumbnail: UIImage?
}

enum NewsURLHandle {
    static func fetchPreviewInfo(from urlString:String) async throws -> PreviewInfo {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let provider = LPMetadataProvider()
        let metadata = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<LPLinkMetadata, Error>) in
            provider.startFetchingMetadata(for: url) { metadata, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let metadata = metadata {
                    continuation.resume(returning: metadata)
                } else {
                    continuation.resume(throwing: URLError(.unknown))
                }
            }
        }
        
        var thumbnail: UIImage? = nil
        if let imageProvider = metadata.imageProvider,
           imageProvider.canLoadObject(ofClass: UIImage.self) {
            thumbnail = try await imageProvider.loadUIImage()
        }
        
        return PreviewInfo(title: metadata.title, thumbnail: thumbnail)
    }
}

extension NSItemProvider {
    func loadUIImage() async throws -> UIImage? {
        try await withCheckedThrowingContinuation { continuation in
            self.loadObject(ofClass: UIImage.self) { object, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let image = object as? UIImage {
                    continuation.resume(returning: image)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}
