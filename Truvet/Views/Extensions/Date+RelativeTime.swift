//
//  Date+RelativeTime.swift
//  Truvet
//
//  Created by signerlabs.
//

import Foundation

extension Date {
    /// English relative-time description
    /// - Within 60s → "Just now"
    /// - Within 1h → "X min ago"
    /// - Within 24h → "X hr ago"
    /// - Yesterday → "Yesterday"
    /// - Within 7 days → "X d ago"
    /// - Beyond → "MMM d"
    var relativeDescription: String {
        let interval = Date().timeIntervalSince(self)

        if interval < 60 {
            return "Just now"
        } else if interval < 3600 {
            let mins = Int(interval / 60)
            return "\(mins) min ago"
        } else if interval < 86400 {
            let hrs = Int(interval / 3600)
            return "\(hrs) hr ago"
        } else if interval < 86400 * 2 {
            return "Yesterday"
        } else if interval < 86400 * 7 {
            let days = Int(interval / 86400)
            return "\(days) d ago"
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US")
            formatter.dateFormat = "MMM d"
            return formatter.string(from: self)
        }
    }

    /// More granular "time divider" used in chat
    /// - Within 1 min → "Just now"
    /// - Same day → "HH:mm"
    /// - Yesterday → "Yesterday HH:mm"
    /// - Otherwise → "MMM d HH:mm"
    var chatTimestamp: String {
        let interval = Date().timeIntervalSince(self)
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")

        if interval < 60 {
            return "Just now"
        }

        let cal = Calendar.current
        if cal.isDateInToday(self) {
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: self)
        }
        if cal.isDateInYesterday(self) {
            formatter.dateFormat = "HH:mm"
            return "Yesterday " + formatter.string(from: self)
        }
        formatter.dateFormat = "MMM d HH:mm"
        return formatter.string(from: self)
    }
}
