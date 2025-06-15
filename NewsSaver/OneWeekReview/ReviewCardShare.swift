//
//  ReviewCardShare.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/15.
//

import SwiftUI
import UIKit

@MainActor
extension View {
    func uiSnapshot(size: CGSize, yOffset: CGFloat = 0, afterUpdates: Bool = true) -> UIImage? {
        let host = UIHostingController(rootView: self)
        host.view.bounds = CGRect(origin: .zero, size: size)
        host.view.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            ctx.cgContext.translateBy(x: 0, y: -yOffset)
            host.view.drawHierarchy(in: host.view.bounds, afterScreenUpdates: afterUpdates)
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
}
