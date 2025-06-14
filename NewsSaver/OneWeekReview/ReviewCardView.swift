//
//  ReviewCardView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/14.
//

import SwiftUI
import BigUIPaging
import SwiftData

struct ReviewCardView: View {
    @Query var newsItems: [NewsItem]
    @State private var selectedIndex : Int = 0
    var body: some View {
        VStack{
            MainTopBar(title: "Review", showBackButton: true, showSearchButton: false)
                .padding(.top)
            Spacer()
            PageView(selection: $selectedIndex) {
                ForEach(newsItems.indices, id: \.self) { i in
                    NewsCardView(news: newsItems[i])
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                        .background(Color.gray.opacity(1))
                }
            }
            .pageViewStyle(.cardDeck)
        }
    }
}

#Preview {
    ReviewCardView()
        .modelContainer(for: NewsItem.self, inMemory: true)
}
