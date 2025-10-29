//
//  Pet.swift
//  Truvet
//
//  Created by 仲炜 on 2025/10/29.
//

import Foundation
import CoreLocation

// MARK: - 品种枚举
enum PetBreed: String, Codable, CaseIterable, Identifiable {
    case goldenRetriever = "golden_retriever"
    case corgi = "corgi"
    case husky = "husky"
    case poodle = "poodle"
    case labrador = "labrador"
    case shibaInu = "shiba_inu"
    case samoyed = "samoyed"
    case chihuahua = "chihuahua"
    case pomeranian = "pomeranian"
    case frenchBulldog = "french_bulldog"
    case borderCollie = "border_collie"
    case germanShepherd = "german_shepherd"
    case beagle = "beagle"
    case mixedBreed = "mixed_breed"
    case other = "other"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .goldenRetriever: return "金毛"
        case .corgi: return "柯基"
        case .husky: return "哈士奇"
        case .poodle: return "泰迪/贵宾"
        case .labrador: return "拉布拉多"
        case .shibaInu: return "柴犬"
        case .samoyed: return "萨摩耶"
        case .chihuahua: return "吉娃娃"
        case .pomeranian: return "博美"
        case .frenchBulldog: return "法斗"
        case .borderCollie: return "边牧"
        case .germanShepherd: return "德牧"
        case .beagle: return "比格"
        case .mixedBreed: return "混血"
        case .other: return "其他"
        }
    }
}

// MARK: - 宠物标签枚举
enum PetTag: String, Codable, CaseIterable, Identifiable {
    case energetic = "energetic"
    case friendly = "friendly"
    case gentle = "gentle"
    case playful = "playful"
    case quiet = "quiet"
    case smart = "smart"
    case loyal = "loyal"
    case curious = "curious"
    case shy = "shy"
    case trained = "trained"
    case lovesKids = "loves_kids"
    case goodWithDogs = "good_with_dogs"
    case lovesFetch = "loves_fetch"
    case lovesWater = "loves_water"
    case foodie = "foodie"

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .energetic: return "活泼"
        case .friendly: return "友好"
        case .gentle: return "温柔"
        case .playful: return "爱玩"
        case .quiet: return "安静"
        case .smart: return "聪明"
        case .loyal: return "忠诚"
        case .curious: return "好奇"
        case .shy: return "害羞"
        case .trained: return "训练有素"
        case .lovesKids: return "喜欢小孩"
        case .goodWithDogs: return "狗缘好"
        case .lovesFetch: return "爱玩飞盘"
        case .lovesWater: return "喜欢游泳"
        case .foodie: return "吃货"
        }
    }

    var emoji: String {
        switch self {
        case .energetic: return "⚡️"
        case .friendly: return "😊"
        case .gentle: return "💕"
        case .playful: return "🎾"
        case .quiet: return "🤫"
        case .smart: return "🧠"
        case .loyal: return "❤️"
        case .curious: return "👀"
        case .shy: return "🙈"
        case .trained: return "🎓"
        case .lovesKids: return "👶"
        case .goodWithDogs: return "🐕"
        case .lovesFetch: return "🥏"
        case .lovesWater: return "💦"
        case .foodie: return "🍖"
        }
    }
}

// MARK: - Pet Model
struct Pet: Identifiable, Codable {
    var id = UUID()
    var name: String = ""
    var avatar: String = "" // Asset名称，如"bella"、"lucky"等
    var breed: PetBreed = .other
    var age: Int = 0 // 年龄（岁）
    var tags: [PetTag] = [] // 自我标签
    var activeTime: String = "" // 活跃时间，如"上午8-10点，下午4-6点"
    var latitude: Double = 0.0
    var longitude: Double  = 0.0

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    // 格式化年龄显示
    var ageDescription: String {
        if age == 0 {
            return "未知"
        } else if age == 1 {
            return "1岁"
        } else {
            return "\(age)岁"
        }
    }

    // 标签显示文本
    var tagsText: String {
        tags.map { $0.displayName }.joined(separator: " · ")
    }
}
