//
//  Date+RelativeTime.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//

import Foundation

extension Date {
    /// 中文相对时间描述
    /// - 60 秒内 → "刚刚"
    /// - 1 小时内 → "X 分钟前"
    /// - 24 小时内 → "X 小时前"
    /// - 昨天 → "昨天"
    /// - 7 天内 → "X 天前"
    /// - 超过 → "M月D日"
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

    /// 聊天界面用的"时间分割"，更精细
    /// - 1 分钟内 → "刚刚"
    /// - 当天 → "HH:mm"
    /// - 昨天 → "昨天 HH:mm"
    /// - 否则 → "M月D日 HH:mm"
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
