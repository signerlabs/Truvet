//
//  ConversationRow.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//

import SwiftUI

/// 消息列表单 cell：头像 + 用户名 + verified + 最后消息预览 + 相对时间 + 未读 badge
struct ConversationRow: View {
    let conversation: ChatConversation

    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .topTrailing) {
                Image(conversation.otherUser.avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 52, height: 52)
                    .clipShape(Circle())

                // 未读小红点（在头像右上角）
                if conversation.unreadCount > 0 {
                    Text(conversation.unreadCount > 99 ? "99+" : "\(conversation.unreadCount)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(Color.red))
                        .offset(x: 2, y: -2)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Text(conversation.otherUser.username)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.primary)

                    if conversation.otherUser.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.accent)
                    }

                    Spacer()

                    Text(conversation.lastActiveAt.relativeDescription)
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                }

                Text(conversation.lastMessagePreview)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

#Preview {
    List {
        ForEach(ChatConversation.sampleConversations) { conv in
            ConversationRow(conversation: conv)
        }
    }
    .listStyle(.plain)
}
