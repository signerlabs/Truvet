//
//  Comment.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//

import Foundation

// MARK: - 评论模型
struct Comment: Identifiable, Codable {
    let id: UUID
    let postId: UUID
    let user: User
    let content: String
    let createdAt: Date
    let likeCount: Int
}

// MARK: - Mock 评论生成器
extension Comment {
    /// 用预定义的中文评论池，按 postId 做稳定打散，保证同一帖子每次进入看到同样的评论
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

    /// 为指定 Post 返回 3-5 条 mock 评论。
    /// 关键：内容/用户/likeCount 都靠 postId 哈希稳定派生，避免每次刷新都换。
    static func samples(for postId: UUID) -> [Comment] {
        // 用 UUID 字节首位做随机种子，保证稳定
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
                // 每条评论时间向前递推 30 分钟～几小时
                createdAt: Date().addingTimeInterval(-Double((i + 1) * 1800 + seedByte * 60)),
                likeCount: baseLike + (i * 2)
            )
        }
    }
}
