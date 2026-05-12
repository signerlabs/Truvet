//
//  ChatConversation.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//

import Foundation

// MARK: - Conversation Model (used by message list cells)
struct ChatConversation: Identifiable, Codable {
    let id: UUID
    let otherUser: User
    let lastMessagePreview: String
    let lastActiveAt: Date
    let unreadCount: Int
}

// MARK: - Preview Data
extension ChatConversation {
    /// One conversation with each of the 5 sampleUsers other than currentUser; add a self-memo to make up 6 conversations
    static let sampleConversations: [ChatConversation] = {
        let me = User.currentUser
        let others = User.sampleUsers.filter { $0.id != me.id }

        // Stable UUID for each conversation (so ChatView can look up the matching messages)
        let convIds: [UUID] = [
            UUID(uuidString: "22222222-0000-0000-0000-000000000001")!,
            UUID(uuidString: "22222222-0000-0000-0000-000000000002")!,
            UUID(uuidString: "22222222-0000-0000-0000-000000000003")!,
            UUID(uuidString: "22222222-0000-0000-0000-000000000004")!,
            UUID(uuidString: "22222222-0000-0000-0000-000000000005")!,
            UUID(uuidString: "22222222-0000-0000-0000-000000000006")!
        ]
        let previews = [
            "明天下午外滩遛狗约不约？",
            "已经发你私信啦，记得查收～",
            "这款狗粮我家狗子也在吃，巨爱",
            "周六的聚会还有名额吗？",
            "感谢分享！已经收藏",
            "你们家小白真的好可爱！"
        ]
        let unread = [2, 0, 1, 0, 0, 3]
        let minutesAgo: [Double] = [5, 35, 120, 360, 1440, 4320]

        return zip(others, 0..<others.count).map { user, i in
            ChatConversation(
                id: convIds[i],
                otherUser: user,
                lastMessagePreview: previews[i],
                lastActiveAt: Date().addingTimeInterval(-minutesAgo[i] * 60),
                unreadCount: unread[i]
            )
        }
    }()
}
