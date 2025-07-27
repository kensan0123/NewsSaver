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
    @State private var isEditing: Bool = false
    @State private var editedOpinion: String = ""
    @FocusState private var isFocused: Bool
    
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
            if isEditing {
                TextEditor(text: $editedOpinion)
                    .font(.body)
                    .foregroundColor(.black)
                    .padding(.horizontal, 10)
                    .focused($isFocused)
                    .onAppear {
                        editedOpinion = news.opinion ?? ""
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isFocused = true
                        }
                    }
                Button("保存") {
                    news.opinion = editedOpinion
                    try? news.modelContext?.save()
                    isEditing = false
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.accentColor)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 30))
            } else {
                Divider()
                ZStack(alignment: .bottom) {
                    Color.clear
                        .contentShape(Rectangle())
                    VStack(alignment: .leading, spacing: 0) {
                        ScrollView {
                            Text(news.opinion ?? "意見はありません")
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .onTapGesture {
                                    isEditing = true
                                }
                            Spacer()
                        }
                    }
                    if !isEditing {
                        NewsLinkButton(newsURL: news.newsURL ?? "")
                            .padding(.bottom, 15)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let sampleNews = NewsItem(
        title: "サンプル記事",
        date: Date(),
        imageData: Data(),
        opinion: "これは意見の例です。",
        newsURL: "https://l.smartnews.com/m-m0MNQIg/9Hwuu4", category: ""
    )

    OpinionListView(news: sampleNews)
        .modelContainer(for: NewsItem.self, inMemory: true)
}
