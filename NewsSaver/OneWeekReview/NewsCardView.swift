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
                .font(.headline)
                .padding(.bottom, 5)
            
            HStack {
                if let uiImage = news.image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 80)
                        .clipped()
                }
                Text(news.opinion ?? "")
            }
            Text(news.opinion ?? "")
            Divider()
            Text(news.opinion ?? "")
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
