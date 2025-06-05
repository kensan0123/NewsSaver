//
//  NewsListView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/03.
//

import SwiftUI

struct NewsListView: View {
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    let newsItems: [NewsItem] = [
        NewsItem(title: "米鉄鋼・アルミ関税2倍の50％に　トランプ氏表明、6月4日から", date:Date(), imageName: "thumbnail"),
        NewsItem(title: "米鉄鋼・アルミ関税2倍の50％に　トランプ氏表明、6月4日から", date:Date(), imageName: "thumbnail"),
        NewsItem(title: "米鉄鋼・アルミ関税2倍の50％に　トランプ氏表明、6月4日から", date:Date(), imageName: "thumbnail"),
        NewsItem(title: "米鉄鋼・アルミ関税2倍の50％に　トランプ氏表明、6月4日から", date:Date(), imageName: "thumbnail"),
        NewsItem(title: "米鉄鋼・アルミ関税2倍の50％に　トランプ氏表明、6月4日から", date:Date(), imageName: "thumbnail"),
        NewsItem(title: "米鉄鋼・アルミ関税2倍の50％に　トランプ氏表明、6月4日から", date:Date(), imageName: "thumbnail"),
        NewsItem(title: "米鉄鋼・アルミ関税2倍の50％に　トランプ氏表明、6月4日から", date:Date(), imageName: "thumbnail"),
    ]
    var filteredItems: [NewsItem] {
        if searchText.isEmpty {
            return newsItems
        } else {
            return newsItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var body: some View {
        VStack(spacing: 0) {
            MainTopBar(
                title: "MyNews",
                showSearchButton: true,
                onSearchTapped: {
                    isSearching.toggle()
                }
            )
                .padding(.top)
            NavigationStack {
                if isSearching {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                }
                List(filteredItems) { item in
                    NewsRowView(news: item)
                }
                .listStyle(.plain)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    NewsListView()
}
