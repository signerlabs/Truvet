//
//  AppNotification.swift
//  Truvet
//
//  Created by signerlabs.
//
//  Note: the name intentionally avoids SwiftUI/Foundation's Notification

import Foundation

// MARK: - Notification Type
enum NotificationType: String, Codable {
    case like = "like"           // Received a like
    case comment = "comment"     // Received a comment
    case follow = "follow"       // New follower
    case system = "system"       // System notification

    /// SF Symbol name
    var iconName: String {
        switch self {
        case .like:    return "heart.fill"
        case .comment: return "text.bubble.fill"
        case .follow:  return "person.fill.badge.plus"
        case .system:  return "bell.fill"
        }
    }
}

// MARK: - Notification Model
struct AppNotification: Identifiable, Codable {
    let id: UUID
    let type: NotificationType
    let fromUser: User?
    let relatedPost: Post?
    let content: String
    let createdAt: Date
    let isRead: Bool
}

// MARK: - Preview Data
extension AppNotification {
    static let sampleNotifications: [AppNotification] = {
        let posts = Post.samplePosts
        let users = User.sampleUsers
        let now = Date()

        return [
            AppNotification(
                id: UUID(),
                type: .like,
                fromUser: users[1], // Cooper's Mom
                relatedPost: posts[0],
                content: "liked your post \"Park day with the pups!\"",
                createdAt: now.addingTimeInterval(-60 * 5),
                isRead: false
            ),
            AppNotification(
                id: UUID(),
                type: .comment,
                fromUser: users[2], // Dr. Liam Chen
                relatedPost: posts[0],
                content: "commented: \"My dog eats that same food and loves it\"",
                createdAt: now.addingTimeInterval(-60 * 25),
                isRead: false
            ),
            AppNotification(
                id: UUID(),
                type: .follow,
                fromUser: users[3], // Shanghai Pet Circle
                relatedPost: nil,
                content: "started following you",
                createdAt: now.addingTimeInterval(-60 * 60 * 2),
                isRead: false
            ),
            AppNotification(
                id: UUID(),
                type: .like,
                fromUser: users[4], // Pet Gear Reviews
                relatedPost: posts[0],
                content: "liked your post",
                createdAt: now.addingTimeInterval(-60 * 60 * 5),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .system,
                fromUser: nil,
                relatedPost: nil,
                content: "This week's featured submission contest is live — share your fur-kid story to win prizes 🎁",
                createdAt: now.addingTimeInterval(-60 * 60 * 8),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .comment,
                fromUser: users[5], // Stray Rescue HQ
                relatedPost: posts[0],
                content: "replied to your comment: \"Adopt, don't shop — full agree 👍\"",
                createdAt: now.addingTimeInterval(-60 * 60 * 24),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .follow,
                fromUser: users[2], // Dr. Liam Chen
                relatedPost: nil,
                content: "started following you",
                createdAt: now.addingTimeInterval(-60 * 60 * 36),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .like,
                fromUser: users[3], // Shanghai Pet Circle
                relatedPost: posts[0],
                content: "liked your post",
                createdAt: now.addingTimeInterval(-60 * 60 * 48),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .system,
                fromUser: nil,
                relatedPost: nil,
                content: "Your pet profile has been approved — welcome to the Truvet community 🐾",
                createdAt: now.addingTimeInterval(-60 * 60 * 72),
                isRead: true
            )
        ]
    }()
}
