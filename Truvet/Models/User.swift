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
    let isVerified: Bool // 是否认证用户
    let bio: String? // 个人简介

    // 关联关系：一个User可以有多个Post和Pet
    // 通过查询 Post.user.id == User.id 获取用户的所有帖子
    // 通过查询 Pet.ownerId == User.id 获取用户的所有宠物
}

// MARK: - 预览数据
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

// MARK: - 当前登录用户（纯 Mock）
extension User {
    /// Demo 中的"我"，默认是铲屎官小王
    static var currentUser: User { sampleUsers[0] }
}

