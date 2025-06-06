//
//  NewsListView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/03.
//

import SwiftUI
import SwiftData

struct NewsListView: View {
    @Query var newsItems: [NewsItem]
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    
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
                        .padding(10)
                        .overlay(
                            HStack {
                                Spacer()
                                if !searchText.isEmpty {
                                    Button(action: {
                                        withAnimation{
                                            searchText = ""
                                            isSearching = false
                                        }
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding(.trailing, 16)
                                }
                            }
                        )
                        .padding(.horizontal)
                        .padding(.vertical, 3)
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
    }
}

#Preview {
    NewsListView()
}
