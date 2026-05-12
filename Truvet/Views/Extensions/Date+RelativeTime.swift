//
//  Date+RelativeTime.swift
//  Truvet
//
//  Created by signerlabs.
//

import Foundation

extension Date {
    /// Chinese relative time description
    /// - Within 60s → "刚刚" (just now)
    /// - Within 1h → "X 分钟前" (X minutes ago)
    /// - Within 24h → "X 小时前" (X hours ago)
    /// - Yesterday → "昨天"
    /// - Within 7 days → "X 天前" (X days ago)
    /// - Beyond → "M月D日" (M/D)
    var relativeDescription: String {
        let interval = Date().timeIntervalSince(self)

        if interval < 60 {
            return "刚刚"
        } else if interval < 3600 {
            return "\(Int(interval / 60)) 分钟前"
        } else if interval < 86400 {
            return "\(Int(interval / 3600)) 小时前"
        } else if interval < 86400 * 2 {
            return "昨天"
        } else if interval < 86400 * 7 {
            return "\(Int(interval / 86400)) 天前"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "zh_CN")
            formatter.dateFormat = "M月d日"
            return formatter.string(from: self)
        }
    }

    /// More granular "time divider" used in chat
    /// - Within 1 min → "刚刚" (just now)
    /// - Same day → "HH:mm"
    /// - Yesterday → "昨天 HH:mm"
    /// - Otherwise → "M月D日 HH:mm"
    var chatTimestamp: String {
        let interval = Date().timeIntervalSince(self)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")

        if interval < 60 {
            return "刚刚"
        }

        let cal = Calendar.current
        if cal.isDateInToday(self) {
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: self)
        }
        if cal.isDateInYesterday(self) {
            formatter.dateFormat = "HH:mm"
            return "昨天 " + formatter.string(from: self)
        }
        formatter.dateFormat = "M月d日 HH:mm"
        return formatter.string(from: self)
    }
}
