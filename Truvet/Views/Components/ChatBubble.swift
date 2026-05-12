//
//  ChatBubble.swift
//  Truvet
//
//  Created by signerlabs.
//

import SwiftUI

/// Chat bubble: my messages right-aligned (accent color) / their messages left-aligned (material background)
struct ChatBubble: View {
    let message: ChatMessage
    /// Other side's avatar (shown on the left for incoming messages)
    let otherAvatar: String

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            if message.isFromMe {
                Spacer(minLength: 60)
                bubbleContent
                Image(User.currentUser.avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
            } else {
                Image(otherAvatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 36, height: 36)
                    .clipShape(Circle())
                bubbleContent
                Spacer(minLength: 60)
            }
        }
        .padding(.horizontal, 12)
    }

    @ViewBuilder
    private var bubbleContent: some View {
        Text(message.content)
            .font(.system(size: 15))
            .foregroundStyle(message.isFromMe ? Color.white : Color.primary)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(message.isFromMe ? Color.accent : Color(.systemGray6))
            )
            .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: message.isFromMe ? .trailing : .leading)
    }
}

/// Time divider (shown when the gap is 5+ minutes)
struct ChatTimeDivider: View {
    let date: Date

    var body: some View {
        Text(date.chatTimestamp)
            .font(.system(size: 11))
            .foregroundStyle(.secondary)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Capsule().fill(Color(.systemGray6)))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
    }
}

#Preview {
    VStack(spacing: 10) {
        ChatTimeDivider(date: Date().addingTimeInterval(-3600))
        ChatBubble(
            message: ChatMessage(id: UUID(), conversationId: UUID(), content: "今天去外滩遛狗吗？", isFromMe: false, createdAt: Date()),
            otherAvatar: "Cooper的麻麻"
        )
        ChatBubble(
            message: ChatMessage(id: UUID(), conversationId: UUID(), content: "好呀好呀，约几点？", isFromMe: true, createdAt: Date()),
            otherAvatar: "Cooper的麻麻"
        )
    }
}
