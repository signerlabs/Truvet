//
//  MessageView.swift
//  Truvet
//
//  Created by signerlabs.
//

import SwiftUI

/// Messages Tab: two top segments (Chats / Notifications)
struct MessageView: View {
    enum Segment: String, CaseIterable, Hashable {
        case chats = "消息"
        case notifications = "通知"
    }

    @State private var segment: Segment = .chats

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SegmentedHeader(
                    items: Segment.allCases,
                    title: { $0.rawValue },
                    selection: $segment
                )
                .background(Color(.systemBackground))

                Divider()
                    .opacity(0.4)

                switch segment {
                case .chats:
                    chatList
                case .notifications:
                    notificationList
                }
            }
            .navigationTitle("消息")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: ChatConversation.self) { conv in
                ChatView(conversation: conv)
            }
        }
    }

    // MARK: - Conversation List
    private var chatList: some View {
        List(ChatConversation.sampleConversations) { conv in
            ZStack {
                // NavigationLink wraps the whole row, hiding the default chevron
                NavigationLink(value: conv) {
                    EmptyView()
                }
                .opacity(0)

                ConversationRow(conversation: conv)
            }
            .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(Color.background)
    }

    // MARK: - Notification List
    private var notificationList: some View {
        List(AppNotification.sampleNotifications) { notification in
            NotificationRow(notification: notification)
                .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(Color.background)
    }
}

// MARK: - ChatConversation Hashable
extension ChatConversation: Hashable {
    static func == (lhs: ChatConversation, rhs: ChatConversation) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

#Preview {
    MessageView()
}
