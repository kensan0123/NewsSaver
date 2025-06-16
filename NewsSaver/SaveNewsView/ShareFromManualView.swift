//
//  ShareFromManualView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/16.
//

import SwiftUI

struct ShareFromManualView: View {
    @State private var showNewsSaveView: Bool = false
    @State private var navigateToIntro = false
    @State private var urlInput: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                MainTopBar(title: "Save", showBackButton: false, showSearchButton: false, onDocTapped: {navigateToIntro.toggle()})
                    .padding(.top)
                TextField("URLをペーストしてください", text: $urlInput)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
                    .padding(.horizontal)
                Button("決定") {
                    hideKeyboard()
                    showNewsSaveView = true
                }
                .buttonStyle(.borderedProminent)
                .disabled( extractURL(from: urlInput.trimmingCharacters(in: .whitespacesAndNewlines)) == nil)
                Spacer()
            }
            .navigationDestination(isPresented: $showNewsSaveView) {
                let trimmed = urlInput.trimmingCharacters(in: .whitespacesAndNewlines)
                let cleaned = extractURL(from: trimmed) ?? trimmed
                NewsSaveView(newsURL: cleaned, extensionContext: nil)
                    .modelContainer(for: NewsItem.self)
            }
            .navigationDestination(isPresented: $navigateToIntro){
                IntroListView()
            }
        }
    }
    private func hideKeyboard() {
        #if os(iOS)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
    }
    private func extractURL(from text: String) -> String? {
        guard let detector = try? NSDataDetector(
                types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return nil
        }
        let range = NSRange(text.startIndex..., in: text)
        return detector.firstMatch(in: text, options: [], range: range)?
            .url?
            .absoluteString
    }
}

#Preview {
    ShareFromManualView()
        .modelContainer(for: NewsItem.self)
}
