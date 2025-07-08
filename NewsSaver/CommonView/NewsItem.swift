//
//  NewsItem.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/03.
//

import SwiftData
import SwiftUI
import Foundation

@Model
class NewsItem {
    var title: String
    var date: Date
    var imageData: Data?
    var opinion: String?
    var newsURL: String?
    var category: String?
    
    init(title: String, date: Date, imageData: Data, opinion: String?, newsURL: String?, category: String?) {
        self.title = title
        self.date = date
        self.imageData = imageData
        self.opinion = opinion
        self.newsURL = newsURL
        self.category = category
    }
    
    var image :UIImage? {
        guard let data = imageData else { return nil }
        return UIImage(data: data)
    }
}
