//
//  PostCard.swift
//  Truvet
//
//  Created by Wei on 2025/10/30.
//

import SwiftUI
import UIKit

struct PostCard: View {
    let post: Post

    /// Fall back to "bella" when the asset is missing, to avoid a blank image
    private func safeImageName(_ name: String) -> String {
        UIImage(named: name) != nil ? name : "bella"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image area
            GeometryReader { geometry in
                ZStack(alignment: .topTrailing) {
                    Image(safeImageName(post.images.first ?? "bella"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.width * 4/3)
                        .clipped()

                    // Multi-image badge
                    if post.images.count > 1 {
                        HStack(spacing: 4) {
                            Image(systemName: "square.on.square")
                                .font(.system(size: 12))
                            Text("\(post.images.count)")
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(Color.accent)
                        )
                        .padding(8)
                    }
                }
            }
            .aspectRatio(3/4, contentMode: .fit)

            // Content area
            VStack(alignment: .leading, spacing: 8) {
                // Title
                Text(post.title)
                    .font(.subheadline)
                    .lineLimit(1)

                // Bottom info bar
                HStack(spacing: 8) {
                    // Author info
                    HStack(spacing: 6) {
                        Image(post.user.avatar)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 12, height: 12)
                            .clipShape(Circle())

                        Text(post.user.username)
                    }

                    Spacer()

                    // Like count
                    Label(formatLikeCount(post.likeCount), systemImage: "heart")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            .padding(8)
            .background(.white)
        }
        .cornerRadius(12)
    }

    // Format the like count for display
    private func formatLikeCount(_ count: Int) -> String {
        if count >= 10000 {
            return String(format: "%.1fw", Double(count) / 10000.0)
        } else if count >= 1000 {
            return String(format: "%.1fk", Double(count) / 1000.0)
        } else {
            return "\(count)"
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        PostCard(post: Post.samplePosts[0])
        PostCard(post: Post.samplePosts[1])
    }
    .padding()
}
