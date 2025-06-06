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
    
    init(title: String, date: Date, imageData: Data, opinion: String?) {
        self.title = title
        self.date = date
        self.imageData = imageData
        self.opinion = opinion
    }
    
    var image :UIImage? {
        guard let data = imageData else { return nil }
        return UIImage(data: data)
    }
}
