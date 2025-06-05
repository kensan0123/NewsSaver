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
    @State private var newsItems: [NewsItem] = []
    
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
                title: "My News",
                showSearchButton: true,
                onSearchTapped: {
                    isSearching.toggle()
                }
            )
                .padding(.top)
         
                if isSearching {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.secondary.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                List(filteredItems) { item in
                    NavigationLink(destination: OpinionListView(news: item)) {
                        NewsRowView(news: item)
                    }
                }
                .listStyle(.plain)
            
            
        }
        .onAppear {
            newsItems = NewsLoader.loadLocalNews()
        }
    }
}

#Preview {
    NewsListView()
}
