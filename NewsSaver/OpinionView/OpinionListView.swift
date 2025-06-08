//
//  OpinionListView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/05.
//

import SwiftUI
import SwiftData

struct OpinionListView: View {
    @Query var newsItems: [NewsItem]
    @Environment(\.dismiss) var dismiss
    
    let news: NewsItem
    var body: some View {
        VStack(spacing: 0) {
            MainTopBar (
                title: "Opinion",
                showBackButton: true,
                showSearchButton: false,
                onBackTapped: {
                    dismiss()
                }
            )
            .padding(.top)
            HStack {
                Spacer()
                Text(news.date, format: .dateTime.year().month().day())
                    .font(.headline)
                    .foregroundStyle(Color.gray)
                    .padding(10)
            }
            HStack {
                Spacer()
                Text(news.title)
                    .font(.title2)
                    .bold()
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 15)
                
            }
            if let uiImage = news.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
            }
            Text(news.opinion ?? "意見はありません")
                .font(.body)
                .padding(.vertical, 20)
                .padding(.horizontal, 10)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let sampleNews = NewsItem(
        title: "サンプル記事",
        date: Date(),
        imageData: Data(),
        opinion: "これは意見の例です。"
    )

    OpinionListView(news: sampleNews)
        .modelContainer(for: NewsItem.self, inMemory: true)
}
