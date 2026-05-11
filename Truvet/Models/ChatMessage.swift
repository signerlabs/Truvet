//
//  ChatMessage.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//

import Foundation

// MARK: - 聊天消息模型
struct ChatMessage: Identifiable, Codable, Equatable {
    let id: UUID
    let conversationId: UUID
    let content: String
    let isFromMe: Bool
    let createdAt: Date
}

// MARK: - Mock 消息生成器
extension ChatMessage {
    /// 6 个会话各自一套对话脚本（双向 5-10 条）
    /// 注意：返回值按 createdAt 升序，UI 顺序展示
    static func samples(for conversationId: UUID) -> [ChatMessage] {
        let scripts: [String: [(String, Bool)]] = [
            // Cooper的麻麻
            "22222222-0000-0000-0000-000000000001": [
                ("在嘛？", false),
                ("在的，怎么啦", true),
                ("明天下午有空一起遛狗吗？", false),
                ("外滩那边人是不是太多", true),
                ("可以去世纪公园，狗友也多", false),
                ("好呀好呀，几点？", true),
                ("下午 3 点吧，南门集合", false),
                ("收到，明天见！", true),
                ("明天下午外滩遛狗约不约？", false)
            ],
            // 宠物医生小李
            "22222222-0000-0000-0000-000000000002": [
                ("您好，咨询下我家狗子最近不爱吃饭", true),
                ("最近天气变化或者换粮了吗？", false),
                ("没换粮，天气倒是冷了", true),
                ("建议先观察 24-48 小时，注意精神状态", false),
                ("如果伴随呕吐拉稀就要送医", false),
                ("好的好的，谢谢医生", true),
                ("已经发你私信啦，记得查收～", false)
            ],
            // 上海宠物圈
            "22222222-0000-0000-0000-000000000003": [
                ("你好呀，关注你好久啦", true),
                ("欢迎欢迎～", false),
                ("看到你们办的聚会，超想参加", true),
                ("下次活动在世纪公园南门集合", false),
                ("这款狗粮我家狗子也在吃，巨爱", false),
                ("我也喂这款，性价比真不错", true)
            ],
            // 宠物用品测评
            "22222222-0000-0000-0000-000000000004": [
                ("姐妹，那款益生菌真的好用吗", true),
                ("我家三只都在用，效果不错", false),
                ("胃口和便便都规律多了", false),
                ("好的，下单试试", true),
                ("周六的聚会还有名额吗？", false),
                ("还有，过来一起呀", true)
            ],
            // 流浪动物救助
            "22222222-0000-0000-0000-000000000005": [
                ("您好，想问下领养流程", true),
                ("先填一份问卷，会有志愿者上门家访", false),
                ("家访通过就可以接狗狗回家啦", false),
                ("好的，问卷在哪里填？", true),
                ("我把链接发你私信", false),
                ("感谢分享！已经收藏", true)
            ],
            // 第 6 个会话（占位，用其中一个 user）
            "22222222-0000-0000-0000-000000000006": [
                ("看到你家小白啦", false),
                ("哈哈是的，2 岁的萨摩", true),
                ("毛量真足", false),
                ("梳毛梳到怀疑人生🥲", true),
                ("你们家小白真的好可爱！", false)
            ]
        ]

        let key = conversationId.uuidString.lowercased()
        // 注意：UUID 大写转小写后字典 key 也需要小写——这里统一处理
        let normalizedScripts = Dictionary(uniqueKeysWithValues:
            scripts.map { ($0.key.lowercased(), $0.value) }
        )
        let script = normalizedScripts[key] ?? []

        // 把脚本转成时间序消息，最后一条时间 ≈ now - 5 分钟，往前每条递推 8 分钟
        let now = Date()
        let total = script.count
        return script.enumerated().map { i, item in
            let (text, isFromMe) = item
            // i = total - 1 时是最新一条，时间最接近 now
            let secondsAgo = Double(total - i) * 8 * 60 + 300
            return ChatMessage(
                id: UUID(),
                conversationId: conversationId,
                content: text,
                isFromMe: isFromMe,
                createdAt: now.addingTimeInterval(-secondsAgo)
            )
        }
    }
}
