//
//  OpinionListView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/05.
//

import SwiftUI

struct OpinionListView: View {
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
            Image(news.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .clipped()
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
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
    OpinionListView(news: NewsItem (
        title: "トヨタ、全固体電池で航続距離1000km達成へ",
        date: Date(),
        imageName: "thumbnail",
        opinion: "これは私の意見です。これは私の意見です。これは私の意見です。これは私の意見です。これは私の意見です。これは私の意見です。これは私の意見です。これは私の意見です。"
    ))
}
