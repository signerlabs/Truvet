//
//  PostDetailView.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//

import SwiftUI
import UIKit

/// Post detail: image carousel + author bar + body + comments + bottom action bar
struct PostDetailView: View {
    let post: Post

    @State private var isFollowing: Bool = false
    @State private var isLiked: Bool = false
    @State private var isFavorited: Bool = false
    @State private var commentDraft: String = ""

    /// Comment data (stable mock)
    private var comments: [Comment] {
        Comment.samples(for: post.id)
    }

    /// Asset fallback
    private func safeImageName(_ name: String) -> String {
        UIImage(named: name) != nil ? name : "bella"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                imageCarousel
                authorBar
                titleAndContent
                tagsRow
                metaRow
                Divider()
                commentsSection
            }
            .padding(.bottom, 16)
        }
        .background(Color.background)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            bottomBar
        }
        .navigationTitle(post.user.username)
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Image Carousel
    private var imageCarousel: some View {
        GeometryReader { geo in
            TabView {
                ForEach(post.images, id: \.self) { image in
                    Image(safeImageName(image))
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.width * 4 / 3)
                        .clipped()
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        }
        .aspectRatio(3.0/4.0, contentMode: .fit)
    }

    // MARK: - Author Bar
    private var authorBar: some View {
        HStack(spacing: 10) {
            Image(post.user.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 4) {
                    Text(post.user.username)
                        .font(.system(size: 14, weight: .semibold))
                    if post.user.isVerified {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.accent)
                    }
                }
                if let bio = post.user.bio {
                    Text(bio)
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }

            Spacer()

            Button {
                withAnimation { isFollowing.toggle() }
            } label: {
                Text(isFollowing ? "已关注" : "关注")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(isFollowing ? Color.secondary : Color.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(isFollowing ? Color(.systemGray6) : Color.accent)
                    )
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
    }

    // MARK: - Title / Body
    private var titleAndContent: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(post.title)
                .font(.title3)
                .fontWeight(.bold)

            Text(post.content)
                .font(.body)
                .lineSpacing(4) // Line spacing ~1.4
                .foregroundStyle(.primary)
        }
        .padding(.horizontal, 16)
    }

    // MARK: - Topic Tags
    private var tagsRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(post.tags, id: \.self) { tag in
                    Text("#\(tag)")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.accent)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Capsule().fill(Color.accent.opacity(0.12)))
                }
            }
            .padding(.horizontal, 16)
        }
    }

    // MARK: - Meta Info
    private var metaRow: some View {
        Text("\(post.likeCount * 7) 次浏览 · \(post.createdAt.relativeDescription) · 上海·浦东")
            .font(.system(size: 12))
            .foregroundStyle(.secondary)
            .padding(.horizontal, 16)
    }

    // MARK: - Comments
    private var commentsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("评论 \(post.commentCount)")
                .font(.system(size: 15, weight: .semibold))
                .padding(.horizontal, 16)

            ForEach(comments) { comment in
                HStack(alignment: .top, spacing: 10) {
                    Image(comment.user.avatar)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(comment.user.username)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.secondary)
                            Spacer()
                            HStack(spacing: 3) {
                                Image(systemName: "heart")
                                    .font(.system(size: 11))
                                Text("\(comment.likeCount)")
                                    .font(.system(size: 11))
                            }
                            .foregroundStyle(.secondary)
                        }
                        Text(comment.content)
                            .font(.system(size: 14))
                        Text(comment.createdAt.relativeDescription)
                            .font(.system(size: 11))
                            .foregroundStyle(.tertiary)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    // MARK: - Bottom Action Bar
    private var bottomBar: some View {
        HStack(spacing: 12) {
            HStack {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                TextField("说点什么...", text: $commentDraft)
                    .font(.system(size: 14))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Capsule().fill(Color(.systemGray6)))

            // Like
            VStack(spacing: 2) {
                Button {
                    withAnimation { isLiked.toggle() }
                } label: {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.system(size: 22))
                        .foregroundStyle(isLiked ? Color.pink : Color.primary)
                }
                .buttonStyle(.plain)
                Text("\(post.likeCount)")
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
            }

            // Favorite
            VStack(spacing: 2) {
                Button {
                    withAnimation { isFavorited.toggle() }
                } label: {
                    Image(systemName: isFavorited ? "star.fill" : "star")
                        .font(.system(size: 22))
                        .foregroundStyle(isFavorited ? Color.yellow : Color.primary)
                }
                .buttonStyle(.plain)
                Text("收藏")
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
            }

            // Share
            VStack(spacing: 2) {
                Button {
                    // Placeholder
                } label: {
                    Image(systemName: "paperplane")
                        .font(.system(size: 22))
                        .foregroundStyle(.primary)
                }
                .buttonStyle(.plain)
                Text("\(post.commentCount)")
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .overlay(alignment: .top) {
            Divider().opacity(0.5)
        }
    }
}

#Preview {
    NavigationStack {
        PostDetailView(post: Post.samplePosts[0])
    }
}
