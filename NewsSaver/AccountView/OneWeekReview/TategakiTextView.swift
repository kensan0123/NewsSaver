//
//  TategakiTextView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/15.
//

import UIKit
import CoreText
import SwiftUI

struct TategakiText_Previews: PreviewProvider {
    static var previews: some View {
        TategakiText(text: """
こんにちは、
わたしの名前はふじきです。
これはswiftuiで実装されています。
「どうやって実装してるのか」って？
それはQiitaの記事を読むとわかりますよ！
""").padding(40)
    }
}

public struct TategakiText: UIViewRepresentable {
    public var text: String?

    public func makeUIView(context: Context) -> TategakiTextView {
        let uiView = TategakiTextView()
        uiView.isOpaque = false
        uiView.text = text
        return uiView
    }

    public func updateUIView(_ uiView: TategakiTextView, context: Context) {
        uiView.text = text
    }
}

public class TategakiTextView: UIView {
    public var text: String? = nil {
        didSet {
            ctFrame = nil
        }
    }
    private var ctFrame: CTFrame? = nil
    
    override public func draw(_ rect: CGRect) {
        guard let context:CGContext = UIGraphicsGetCurrentContext() else {
            return
        }
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -rect.height)
        
        let baseAttributes: [NSAttributedString.Key: Any] = [
            .verticalGlyphForm: true,
            .font: UIFont(name: "HiraMinProN-W6", size: 20) ?? .systemFont(ofSize: 20)
        ]
        let attributedText = NSMutableAttributedString(string: text ?? "", attributes: baseAttributes)
        let setter = CTFramesetterCreateWithAttributedString(attributedText)
        let path = CGPath(rect: rect, transform: nil)
        let frameAttrs = [
            kCTFrameProgressionAttributeName: CTFrameProgression.rightToLeft.rawValue,
        ]
        let ct = CTFramesetterCreateFrame(setter, CFRangeMake(0, 0), path, frameAttrs as CFDictionary)
        ctFrame = ct
        
        CTFrameDraw(ct, context)
    }
}
