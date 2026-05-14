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
    /// Use a predefined English comment pool, scrambled deterministically by postId so the same post always shows the same comments
    private static let commentPool: [(String, Int)] = [
        ("So adorable! Can I steal a cuddle? 😍", 23),
        ("Drop the dog food link, please!", 17),
        ("My golden looks just like yours — instant connection", 9),
        ("Beautiful coat — what are you feeding them?", 5),
        ("Jealous. My husky redecorates the apartment daily.", 41),
        ("Where in Shanghai is this? Want to take mine there", 12),
        ("Saved — gonna try this on the weekend", 3),
        ("Pet parents work hard, lucky fur kids", 8),
        ("Posts like this make my whole day", 19),
        ("Mine learned this too, but only performs for treats 😂", 31),
        ("Pat pat, this is therapy", 6),
        ("Curious — what age did you start training?", 4),
        ("Screenshotting this for the meme folder lol", 27),
        ("Adopt, don't shop — full agree 👍", 56),
        ("First time seeing this breed, so cool!", 2)
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
