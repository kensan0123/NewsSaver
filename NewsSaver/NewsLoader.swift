//
//  NewsLoader.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/05.
//

import Foundation

struct NewsLoader {
    static func loadLocalNews() -> [NewsItem] {
        guard let url = Bundle.main.url(forResource: "NewsSave", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return []
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            return try decoder.decode([NewsItem].self, from: data)
        } catch {
            print("デコード失敗：\(error)")
            return []
        }
    }
}
