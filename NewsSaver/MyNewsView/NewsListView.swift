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
    @Environment(\.modelContext) private var modelContext
    
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var navigateToIntro = false
    // 削除用
    @State private var showDeleteAlert: Bool = false
    @State private var itemsToDelete: [NewsItem] = []
    
    var filteredItems: [NewsItem] {
        if searchText.isEmpty {
            return newsItems
        } else {
            return newsItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                MainTopBar(
                    title: "My News",
                    showSearchButton: true,
                    onSearchTapped: {
                        isSearching.toggle()
                    },
                    onDocTapped: {
                        navigateToIntro.toggle()
                    }
                )
                .padding(.top)
                
                if isSearching {
                    searchBox
                }
                if newsItems.isEmpty {
                    Text("保存されたニュースはありません")
                        .font(.headline)
                        .padding()
                    Spacer()
                } else {
                    List {
                        ForEach(filteredItems, id: \.persistentModelID) { item in
                            NavigationLink{OpinionListView(news: item)} label: {
                                NewsRowView(news: item)
                            }
                        }
                        .onDelete{ offsets in
                            itemsToDelete = offsets.map {filteredItems[$0]}
                            showDeleteAlert = true
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationDestination(isPresented: $navigateToIntro){
                IntroListView()
            }
            .alert("このニュースを削除しますか？", isPresented: $showDeleteAlert) {
                Button("削除", role: .destructive) {
                        deleteSelectedItems()
                }
                Button("キャンセル", role: .cancel) {
                    itemsToDelete.removeAll()
                }
            } message: {
                Text("保存したニュースを削除しますか？")
            }
        }
    }
    private var searchBox: some View {
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
    private func deleteSelectedItems() {
        for item in itemsToDelete {
             modelContext.delete(item)
        }
        try? modelContext.save()
        itemsToDelete.removeAll()
    }
}

#Preview {
    NewsListView()
}
