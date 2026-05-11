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

    /// Asset 不存在时回退到 bella，避免出现空白图
    private func safeImageName(_ name: String) -> String {
        UIImage(named: name) != nil ? name : "bella"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // 图片区域
            GeometryReader { geometry in
                ZStack(alignment: .topTrailing) {
                    Image(safeImageName(post.images.first ?? "bella"))
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.width * 4/3)
                        .clipped()
                    
                    //多图标识
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

            // 内容区域
            VStack(alignment: .leading, spacing: 8) {
                // 标题
                Text(post.title)
                    .font(.subheadline)
                    .lineLimit(1)

                // 底部信息栏
                HStack(spacing: 8) {
                    // 作者信息
                    HStack(spacing: 6) {
                        Image(post.user.avatar)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 12, height: 12)
                            .clipShape(Circle())

                        Text(post.user.username)
                    }

                    Spacer()

                    // 点赞数
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

    // 格式化点赞数显示
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
