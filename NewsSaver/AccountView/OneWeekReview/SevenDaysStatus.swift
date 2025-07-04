//
//  SevenDaysStatus.swift
//  NewsSaver
//
//  Created by 中村健介 on 2025/06/15.
//
import Foundation
import SwiftData

extension Collection where Element == NewsItem {
    func hasSevenDaysContinue(days: Int, from referenceDate: Date = .now, calender: Calendar = .current) -> Bool {
        var day = calender.startOfDay(for: referenceDate)
        for _ in 0..<days {
            guard self.contains(where: { calender.isDate($0.date, inSameDayAs: day)})
            else { return false }
            day = calender.date(byAdding: .day, value: -1, to: day)!
        }
        return true
    }
}
