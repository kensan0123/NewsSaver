//
//  NewsLinkButton.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/23.
//

import SwiftUI

struct NewsLinkButton: View {
    @Environment(\.openURL) private var openURL
    var newsURL: String
    var body: some View {
        Button {
            if let url = URL(string: newsURL) {
                openURL(url)
            }
        } label: {
            Label("ニュースへ移動する", systemImage: "arrowshape.turn.up.left.circle")
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.accentColor)
                .foregroundStyle(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }
    }
}

#Preview {
    NewsLinkButton(newsURL: "https://www.nikk.com/article/DGXZQOCD200HI0Q5A620C2000000/")
}
