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
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text(news.title)
                .font(.system(size: 24, weight: .bold, design: .default))
                .padding(.bottom, 5)
            
            HStack(spacing: 0) {
                if let uiImage = news.image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth:200, maxHeight: 150)
                        .clipped()
                        .padding(5)
                        .layoutPriority(1)
                }
                
                TategakiText(text: news.opinion)
                    .frame(maxWidth: .infinity, maxHeight: 150, alignment: .topTrailing)
                    .padding(.bottom, 5)
            }
            TategakiText(text: news.opinion)
                .frame(maxWidth: .infinity, maxHeight: 160)
                .padding(.bottom, 5)
            TategakiText(text: news.opinion)
                .frame(maxWidth: .infinity, maxHeight: 160)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        
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
