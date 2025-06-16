//
//  FirstIntroView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/16.
//

import SwiftUI

struct FirstIntroView: View {
    @State private var currentPageIndex: Int = 0
    @State private var navigateToMain: Bool = false
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    @Environment(\.dismiss) var dismiss
    let introPages = [
        IntroPageModel(headerTitle: "手順１：保存したいニュースの「共有」から「その他」を選択",imageName: "other_intro"),
        IntroPageModel(headerTitle: "手順２：「NewsSaver」を選択",imageName: "add_intro"),
    ]
    var body: some View {
        NavigationStack {
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
                
                Button("始める") {
                    hasLaunchedBefore = true
                    navigateToMain = true
                }
                .buttonStyle(.borderedProminent)
                .padding(.vertical, 24)
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $navigateToMain) {
                ContentView()
            }
        }
    }
}

#Preview {
    IntroListView()
}
