//
//  NotificationRow.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//

import SwiftUI

/// Notification list cell: icon + source user + body + relative time + (left-side blue dot when unread)
struct NotificationRow: View {
    let notification: AppNotification

    /// Icon background color per notification type
    private var iconBackground: Color {
        switch notification.type {
        case .like:    return .pink
        case .comment: return .blue
        case .follow:  return .green
        case .system:  return .orange
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Unread blue dot (also a placeholder to keep alignment)
            Circle()
                .fill(notification.isRead ? Color.clear : Color.blue)
                .frame(width: 8, height: 8)
                .padding(.top, 18)

            // User avatar or plain icon
            ZStack(alignment: .bottomTrailing) {
                if let fromUser = notification.fromUser {
                    Image(fromUser.avatar)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(iconBackground.opacity(0.15))
                        .frame(width: 44, height: 44)
                        .overlay(
                            Image(systemName: notification.type.iconName)
                                .font(.system(size: 18))
                                .foregroundStyle(iconBackground)
                        )
                }

                // Type badge (bottom-right of avatar, not shown for system notifications)
                if notification.fromUser != nil {
                    Circle()
                        .fill(iconBackground)
                        .frame(width: 18, height: 18)
                        .overlay(
                            Image(systemName: notification.type.iconName)
                                .font(.system(size: 9, weight: .bold))
                                .foregroundStyle(.white)
                        )
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                if let fromUser = notification.fromUser {
                    Text(fromUser.username)
                        .font(.system(size: 14, weight: .semibold))
                }
                Text(notification.content)
                    .font(.system(size: 13))
                    .foregroundStyle(notification.fromUser == nil ? .primary : .secondary)
                    .lineLimit(3)

                Text(notification.createdAt.relativeDescription)
                    .font(.system(size: 11))
                    .foregroundStyle(.tertiary)
            }

            Spacer(minLength: 0)

            // Post thumbnail (if any)
            if let post = notification.relatedPost, let firstImage = post.images.first {
                Image(firstImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}

#Preview {
    List {
        ForEach(AppNotification.sampleNotifications) { n in
            NotificationRow(notification: n)
        }
    }
    .listStyle(.plain)
}
