//
//  NewsRowView.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/03.
//

import SwiftUI

struct NewsRowView: View {
    let news: NewsItem
    var body: some View {
        HStack (alignment: .top, spacing: 12) {
            Image(news.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 80)
                .clipped()
                .alignmentGuide(.top) { d in d[.top] }
            VStack(alignment: .leading, spacing: 4) {
                Text(news.title)
                    .font(.headline)
                    .bold()
                    .lineLimit(3, reservesSpace: true)
                    .fixedSize(horizontal: false, vertical: true)
                HStack {
                    Spacer()
                    Text(news.date, format: .dateTime.year().month().day())
                        .font(.footnote)
                        .foregroundStyle(Color(.gray))
                }
                
            }
            
        }
        .frame(height: 75)
        .padding(.vertical, 8)
    }
}
