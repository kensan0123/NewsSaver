//
//  NewsItem.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/03.
//

import SwiftUI
import Foundation

struct NewsItem: Identifiable, Hashable, Codable {
    let id = UUID()
    let title: String
    var date: Date
    var imageName: String
    var opinion: String?
    //var thumbnail: String のちにURL取得に変更
    
    private enum CodingKeys: String, CodingKey {
        case title, date, imageName, opinion
    }
}
