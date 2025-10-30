//
//  Post.swift
//  Truvet
//
//  Created by Wei on 2025/10/30.
//

import Foundation
import CoreLocation

struct Post: Identifiable, Codable {
    let id: UUID
    let images: [String] // 图片URL数组
    let title: String // 标题
    let content: String // 正文内容
    let likeCount: Int // 点赞数
    let commentCount: Int // 评论数
    let user: User // 作者信息 - 一个Post只能属于一个User
    let tags: [String] // 话题标签
    let createdAt: Date // 发布时间
    var latitude: Double = 0.0
    var longitude: Double  = 0.0

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}

// MARK: - 预览数据
extension Post {
    static let samplePosts = [
        Post(
            id: UUID(),
            images: ["bella", "cooper", "max"],
            title: "带狗狗去公园玩啦～",
            content: "今天天气真好，带着我家的宝贝们去公园散步，它们玩得可开心了！#遛狗日常 阳光明媚的周末，最适合带毛孩子出来透透气💕",
            likeCount: 1234,
            commentCount: 89,
            user: User.sampleUsers[0], // 铲屎官小王
            tags: ["遛狗日常", "狗狗", "宠物生活"],
            createdAt: Date().addingTimeInterval(-3600),
            latitude: 31.2219,
            longitude: 121.5383
        ),
        Post(
            id: UUID(),
            images: ["豆豆"],
            title: "新技能GET！握手啦🐾",
            content: "经过两周的训练，Cooper终于学会握手了！每次给它零食的时候都会主动伸出小爪爪，太可爱了吧～各位铲屎官有什么好的训练技巧吗？",
            likeCount: 892,
            commentCount: 56,
            user: User.sampleUsers[1], // Cooper的麻麻
            tags: ["狗狗训练", "宠物技能", "日常分享"],
            createdAt: Date().addingTimeInterval(-7200),
            latitude: 31.2304,
            longitude: 121.4737
        ),
        Post(
            id: UUID(),
            images: ["可乐", "bella"],
            title: "宠物医院体检记录📋",
            content: "今天带Max和Bella去做年度体检，两只狗狗都很健康！医生说体重控制得不错，继续保持～提醒大家记得定期给毛孩子做体检哦",
            likeCount: 2156,
            commentCount: 134,
            user: User.sampleUsers[2], // 宠物医生小李
            tags: ["宠物健康", "体检", "养宠日常"],
            createdAt: Date().addingTimeInterval(-14400),
            latitude: 31.2020,
            longitude: 121.4985
        ),
        Post(
            id: UUID(),
            images: ["泡芙", "max", "cooper"],
            title: "周末狗狗聚会🎉",
            content: "组织了一场狗狗聚会，三只小可爱玩得超级开心！从早上玩到下午，累得回家倒头就睡😴 有没有上海的铲屎官想一起组织下次聚会？",
            likeCount: 3421,
            commentCount: 287,
            user: User.sampleUsers[3], // 上海宠物圈
            tags: ["狗狗聚会", "宠物社交", "上海"],
            createdAt: Date().addingTimeInterval(-21600),
            latitude: 31.1843,
            longitude: 121.5219
        ),
        Post(
            id: UUID(),
            images: ["小白", "bella"],
            title: "狗粮测评｜这款真的绝了！",
            content: "最近试了这款新的天然狗粮，Cooper和Bella都超级喜欢！营养配比也很科学，毛色明显变亮了。分享给大家～有需要的可以看评论区链接",
            likeCount: 567,
            commentCount: 42,
            user: User.sampleUsers[4], // 宠物用品测评
            tags: ["狗粮测评", "宠物用品", "种草"],
            createdAt: Date().addingTimeInterval(-28800),
            latitude: 31.1956,
            longitude: 121.4310
        ),
        Post(
            id: UUID(),
            images: ["lucky"],
            title: "救助流浪狗的故事❤️",
            content: "一个月前在小区门口遇到这只流浪的Max，当时瘦得皮包骨头...现在经过悉心照料已经恢复健康了！决定正式收养它💕 呼吁大家以领养代替购买",
            likeCount: 8923,
            commentCount: 456,
            user: User.sampleUsers[5], // 流浪动物救助
            tags: ["流浪狗救助", "领养", "公益"],
            createdAt: Date().addingTimeInterval(-43200),
            latitude: 31.2165,
            longitude: 121.4451
        )
    ]
}
