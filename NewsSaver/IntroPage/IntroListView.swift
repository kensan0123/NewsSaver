//
//  IntroListView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/11.
//

import SwiftUI

struct IntroListView: View {
    @State private var currentPageIndex: Int = 0
    @Environment(\.dismiss) var dismiss
    let introPages = [
        IntroPageModel(headerTitle: "手順１：「共有」から「その他」を選択",imageName: "other_intro"),
        IntroPageModel(headerTitle: "手順２：「NewsSaver」を選択",imageName: "news_saver_intro"),
    ]
    var body: some View {
        VStack(spacing: 0) {
            MainTopBar(
                title: "intro",
               showBackButton: true,
               showSearchButton: false,
               onBackTapped: {
                dismiss()
               }
            )
                .padding(.top)
            TabView(selection: $currentPageIndex) {
                ForEach(Array(introPages.enumerated()), id: \.offset) { index, introPage in
                    IntroPageView(pageModel: introPage)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    IntroListView()
}
