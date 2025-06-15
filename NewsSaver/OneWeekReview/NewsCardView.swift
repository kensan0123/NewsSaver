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
            
            HStack {
                if let uiImage = news.image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFit()
                        .frame(maxWidth: 250)
                        .padding(.horizontal, 30)
                        .clipped()
                        .padding(.vertical, 10)
                }
            }
            TategakiText(text: news.opinion)
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
