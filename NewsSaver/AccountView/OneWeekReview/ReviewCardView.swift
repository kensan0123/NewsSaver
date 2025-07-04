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
    @Environment(\.dismiss) var dismiss
    @State private var selectedIndex : Int = 0
    
    @State private var shareImage: UIImage?
    @State private var isShowingShareSheet: Bool = false
    
    private var isContinued: Bool {
        newsItems.hasSevenDaysContinue(days: 7)
    }
    
    private var weeklyNews: [NewsItem] {
        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        return newsItems
            .filter { $0.date >= oneWeekAgo }
            .sorted { $0.date < $1.date }
    }
    var body: some View {
        VStack{
            MainTopBar(title: "Review", showBackButton: true, showSearchButton: false, onBackTapped: {dismiss()}, showShareButton: true, onShareTapped: {shareCard()})
                .padding(.top)
            Spacer()
            switch (newsItems.isEmpty, weeklyNews.isEmpty) {
            case (true, _):
                Text("保存されたニュースはありません")
                    .font(.headline)
                    .padding()
                Spacer()
            case (false, true):
                Text("1週間以内で保存されたニュースはありません")
                    .font(.headline)
                    .padding()
                Spacer()
            case(false, false):
                PageView(selection: $selectedIndex) {
                    ForEach(weeklyNews.indices, id: \.self) { i in
                        NewsCardView(news: weeklyNews[i], continued: isContinued)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding()
                            .background(Color(red: 0.90, green: 0.90, blue: 0.90))
                    }
                }
                .pageViewStyle(.cardDeck)
                }
        }
        .sheet(isPresented: $isShowingShareSheet) {
            if let image = shareImage {
                ShareSheet(activityItems: [image])
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    @MainActor
    private func shareCard() {
        guard !weeklyNews.isEmpty else { return }
        let cardView = NewsCardView(news: weeklyNews[selectedIndex], continued: isContinued)
        let targetSize = CGSize(width: 400, height: 640)
        if let img = cardView.uiSnapshot(size: targetSize, yOffset: 60) {
            shareImage = img
            isShowingShareSheet.toggle()
        }
    }
}
#Preview {
    ReviewCardView()
        .modelContainer(for: NewsItem.self, inMemory: true)
}
