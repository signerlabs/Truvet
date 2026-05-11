//
//  AppNotification.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//
//  注意：命名故意避开 SwiftUI/Foundation 的 Notification

import Foundation

// MARK: - 通知类型
enum NotificationType: String, Codable {
    case like = "like"           // 收到点赞
    case comment = "comment"     // 收到评论
    case follow = "follow"       // 新关注
    case system = "system"       // 系统通知

    /// SF Symbol 名
    var iconName: String {
        switch self {
        case .like:    return "heart.fill"
        case .comment: return "text.bubble.fill"
        case .follow:  return "person.fill.badge.plus"
        case .system:  return "bell.fill"
        }
    }
}

// MARK: - 通知模型
struct AppNotification: Identifiable, Codable {
    let id: UUID
    let type: NotificationType
    let fromUser: User?
    let relatedPost: Post?
    let content: String
    let createdAt: Date
    let isRead: Bool
}

// MARK: - 预览数据
extension AppNotification {
    static let sampleNotifications: [AppNotification] = {
        let posts = Post.samplePosts
        let users = User.sampleUsers
        let now = Date()

        return [
            AppNotification(
                id: UUID(),
                type: .like,
                fromUser: users[1], // Cooper的麻麻
                relatedPost: posts[0],
                content: "赞了你的动态「带狗狗去公园玩啦～」",
                createdAt: now.addingTimeInterval(-60 * 5),
                isRead: false
            ),
            AppNotification(
                id: UUID(),
                type: .comment,
                fromUser: users[2], // 宠物医生小李
                relatedPost: posts[0],
                content: "评论了你：「这款狗粮我家狗子也在吃」",
                createdAt: now.addingTimeInterval(-60 * 25),
                isRead: false
            ),
            AppNotification(
                id: UUID(),
                type: .follow,
                fromUser: users[3], // 上海宠物圈
                relatedPost: nil,
                content: "关注了你",
                createdAt: now.addingTimeInterval(-60 * 60 * 2),
                isRead: false
            ),
            AppNotification(
                id: UUID(),
                type: .like,
                fromUser: users[4], // 宠物用品测评
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
                fromUser: users[5], // 流浪动物救助
                relatedPost: posts[0],
                content: "回复了你的评论：「领养代替购买，必须点赞👍」",
                createdAt: now.addingTimeInterval(-60 * 60 * 24),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .follow,
                fromUser: users[2], // 宠物医生小李
                relatedPost: nil,
                content: "关注了你",
                createdAt: now.addingTimeInterval(-60 * 60 * 36),
                isRead: true
            ),
            AppNotification(
                id: UUID(),
                type: .like,
                fromUser: users[3], // 上海宠物圈
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
