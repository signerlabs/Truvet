//
//  Comment.swift
//  Truvet
//
//  Created by signerlabs.
//

import Foundation

// MARK: - Comment Model
struct Comment: Identifiable, Codable {
    let id: UUID
    let postId: UUID
    let user: User
    let content: String
    let createdAt: Date
    let likeCount: Int
}

// MARK: - Mock Comment Generator
extension Comment {
    /// Use a predefined Chinese comment pool, scrambled deterministically by postId so the same post always shows the same comments
    private static let commentPool: [(String, Int)] = [
        ("好可爱！能蹭一下吗😍", 23),
        ("求同款狗粮链接！", 17),
        ("我家也是金毛～感觉好亲切", 9),
        ("狗子毛色真好，平时吃啥？", 5),
        ("羡慕了，我家二哈拆家王", 41),
        ("这是上海哪里呀，想带我家狗子去打卡", 12),
        ("已经收藏，周末试试", 3),
        ("铲屎官辛苦啦，毛孩子有福气", 8),
        ("看到这种内容心情就变好了", 19),
        ("我家狗狗也学会了，但只在有零食时才表演😂", 31),
        ("摸摸头，太治愈了", 6),
        ("请问几个月开始训练比较好？", 4),
        ("这表情包我截了哈哈哈", 27),
        ("领养代替购买，必须点赞👍", 56),
        ("第一次看到这种品种，好特别", 2)
    ]

    /// Return 3-5 mock comments for a given Post.
    /// Key idea: content / user / likeCount are all derived deterministically from postId hash, so they don't change on refresh.
    static func samples(for postId: UUID) -> [Comment] {
        // Use the first byte of the UUID as a stable random seed
        let seedByte = Int(postId.uuid.0)
        let count = 3 + (seedByte % 3) // 3...5
        let users = User.sampleUsers
        let offset = seedByte % commentPool.count

        return (0..<count).map { i in
            let poolIndex = (offset + i * 3) % commentPool.count
            let (text, baseLike) = commentPool[poolIndex]
            let user = users[(offset + i) % users.count]

            return Comment(
                id: UUID(),
                postId: postId,
                user: user,
                content: text,
                // Each comment is 30 minutes to a few hours older than the previous one
                createdAt: Date().addingTimeInterval(-Double((i + 1) * 1800 + seedByte * 60)),
                likeCount: baseLike + (i * 2)
            )
        }
    }
}
