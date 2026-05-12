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
                content: "赞了你的动态「带狗狗去公园玩啦～」",
                createdAt: now.addingTimeInterval(-60 * 5),
                isRead: false
            ),
            AppNotification(
                id: UUID(),
                type: .comment,
                fromUser: users[2], // Pet doctor Li
                relatedPost: posts[0],
                content: "评论了你：「这款狗粮我家狗子也在吃」",
                createdAt: now.addingTimeInterval(-60 * 25),
                isRead: false
            ),
            AppNotification(
                id: UUID(),
                type: .follow,
                fromUser: users[3], // Shanghai Pet Circle
                relatedPost: nil,
                content: "关注了你",
                createdAt: now.addingTimeInterval(-60 * 60 * 2),
                isRead: false
            ),
            AppNotification(
                id: UUID(),
                type: .like,
                fromUser: users[4], // Pet Supplies Reviews
                relatedPost: posts[0],
                content: "赞了你的动态",
                createdAt: now.addingTimeInterval(-60 * 60 * 5),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .system,
                fromUser: nil,
                relatedPost: nil,
                content: "本周精选投稿活动开启，分享你和毛孩子的故事赢取好礼🎁",
                createdAt: now.addingTimeInterval(-60 * 60 * 8),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .comment,
                fromUser: users[5], // Stray Animal Rescue
                relatedPost: posts[0],
                content: "回复了你的评论：「领养代替购买，必须点赞👍」",
                createdAt: now.addingTimeInterval(-60 * 60 * 24),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .follow,
                fromUser: users[2], // Pet doctor Li
                relatedPost: nil,
                content: "关注了你",
                createdAt: now.addingTimeInterval(-60 * 60 * 36),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .like,
                fromUser: users[3], // Shanghai Pet Circle
                relatedPost: posts[0],
                content: "赞了你的动态",
                createdAt: now.addingTimeInterval(-60 * 60 * 48),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .system,
                fromUser: nil,
                relatedPost: nil,
                content: "你的宠物档案已通过审核，欢迎加入 Truvet 社区🐾",
                createdAt: now.addingTimeInterval(-60 * 60 * 72),
                isRead: true
            )
        ]
    }()
}
