//
//  NewsCardView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/15.
//

import SwiftUI
import SwiftData

struct NewsCardView: View {
    let news: NewsItem
    
    private let rowHeight: CGFloat = 150
    private let font = UIFont(name: "HiraMinProN-W6", size: 20) ?? .systemFont(ofSize: 20)
    
    var body: some View {
        GeometryReader { geometry in
            let parts = chunkedText(maxCounts: [28, 77])
            VStack(alignment: .leading, spacing: 0) {
                Text(news.title)
                    .font(.system(size: 24, weight: .bold, design: .default))
                    .padding(.bottom, 5)
                
                HStack(spacing: 0) {
                    if let uiImage = news.image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth:200, maxHeight: rowHeight)
                            .clipped()
                            .padding(5)
                            .layoutPriority(1)
                    }
                    
                    TategakiText(text: parts[0])
                        .frame(width: .infinity, height: rowHeight, alignment: .topTrailing)
                        .padding(.bottom, 10)
                }
                TategakiText(text: parts[1])
                    .frame(width: .infinity, height: rowHeight)
                    .padding(.bottom, 10)
                TategakiText(text: parts[2])
                    .frame(width: .infinity, height: rowHeight)
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
    
    private func chunkedText(maxCounts: [Int]) -> [String] {
        var rest = (news.opinion ?? "")[...]
        var chunks: [String] = []
        
        for limit in maxCounts where !rest.isEmpty {
            chunks.append(String(rest.prefix(limit)))
            rest = rest.dropFirst(limit)
        }
        if !rest.isEmpty {
            chunks.append(String(rest))
        }
        while chunks.count < maxCounts.count + 1 {
            chunks.append("")
        }
        return chunks
    }
}

#Preview {
    let sampleNews = NewsItem(
        title: "タイトル",
        date: Date(),
        imageData: Data(),
        opinion: "これは意見の例です。"
    )
    NewsCardView(news: sampleNews)
        .modelContainer(for: NewsItem.self, inMemory: true)
}
