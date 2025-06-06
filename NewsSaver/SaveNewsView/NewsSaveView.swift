//
//  NewsSaveView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/05.
//

import SwiftUI
import SwiftData

struct NewsSaveView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var previewTitle: String?
    @State private var previewThumbnail: UIImage?
    @State var myopinion: String = ""
    @FocusState var isFocused: Bool
    
    let news: NewsItem
    
    var body: some View {
        VStack {
            MainTopBar(
                title: "Save",
                showBackButton: true,
                showSearchButton: false,
            )
            .padding(.top)
            HStack {
                if let title = previewTitle {
                    Text(title)
                        .font(.title2)
                        .bold()
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                        .padding(.horizontal, 15)
                }
            }
            if let thumbnail = previewThumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 250)
                    .clipped()
                    .padding(.horizontal, 30)
                    .padding(.vertical, 5)
            }
                
            HStack {
                Spacer()
                Button("保存"){
                    if let thumbnail = previewThumbnail,
                       let imageData = thumbnail.jpegData(compressionQuality: 0.8){
                        let newItem = NewsItem(
                            title: previewTitle ?? news.title,
                            date: Date(),
                            imageData: imageData,
                            opinion: myopinion
                            )
                        modelContext.insert(newItem)
                        isFocused = false
                    }
                }
                .padding(.horizontal, 10)
            }
            TextEditor(text: $myopinion)
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .focused($isFocused)
            Spacer()
        }
        .onAppear {
            Task {
                await getMetadata(url: "https://www.nikkei.com/article/DGXZQOGM05D2U0V00C25A6000000/")
            }
        }
    }
    private func getMetadata(url: String) async {
        do {
            let result = try await NewsURLHandle.fetchPreviewInfo(from: url)
            DispatchQueue.main.async {
                self.previewTitle = result.title
                self.previewThumbnail = result.thumbnail
            }
        } catch {
            print("エラー：\(error)")
        }
    }
}

//#Preview {
//    NewsSaveView(news: <#NewsItem#>)
//}
