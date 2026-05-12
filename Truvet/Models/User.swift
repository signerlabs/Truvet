//
//  User.swift
//  Truvet
//
//  Created by Wei on 2025/10/30.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let username: String
    let avatar: String
    let isVerified: Bool // Whether the user is verified
    let bio: String? // User bio

    // Relationships: a User can have multiple Posts and Pets
    // Query Post.user.id == User.id to get all posts of a user
    // Query Pet.ownerId == User.id to get all pets of a user
}

// MARK: - Preview Data
extension User {
    static let sampleUsers = [
        User(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
            username: "铲屎官小王",
            avatar: "铲屎官小王",
            isVerified: true,
            bio: "资深铲屎官 | 三只狗狗的主人 | 分享养宠日常"
        ),
        User(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
            username: "Cooper的麻麻",
            avatar: "Cooper的麻麻",
            isVerified: false,
            bio: "Cooper妈妈 | 新手铲屎官 | 记录成长点滴"
        ),
        User(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
            username: "宠物医生小李",
            avatar: "宠物医生小李",
            isVerified: true,
            bio: "执业宠物医师 | 10年临床经验 | 健康咨询"
        ),
        User(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
            username: "上海宠物圈",
            avatar: "上海宠物圈",
            isVerified: true,
            bio: "上海最活跃的宠物社群 | 组织线下聚会"
        ),
        User(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
            username: "宠物用品测评",
            avatar: "宠物用品测评",
            isVerified: true,
            bio: "专业测评 | 好物推荐 | 避雷指南"
        ),
        User(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000006")!,
            username: "流浪动物救助",
            avatar: "流浪动物救助",
            isVerified: true,
            bio: "公益组织 | 救助流浪动物 | 领养代替购买"
        )
    ]
}

// MARK: - Current Logged-in User (pure mock)
extension User {
    /// "Me" in the demo, defaults to the first sample user
    static var currentUser: User { sampleUsers[0] }
}

