//
//  Pet.swift
//  Truvet
//
//  Created by 仲炜 on 2025/10/29.
//

import Foundation
import CoreLocation

// MARK: - Pet Model
struct Pet: Identifiable, Codable {
    var id = UUID()
    var ownerId: UUID // Associated user ID - a Pet belongs to exactly one User
    var name: String = ""
    var avatar: String = "" // Asset name, e.g. "bella", "lucky"
    var breed: PetBreed = .other
    var age: Int = 0 // Age in years
    var tags: [PetTag] = [] // Self-described tags
    var activeTime: String = "" // Active time, e.g. "8-10 AM, 4-6 PM"
    var latitude: Double = 0.0
    var longitude: Double  = 0.0

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }

    // Formatted age display
    var ageDescription: String {
        if age == 0 {
            return "未知"
        } else if age == 1 {
            return "1岁"
        } else {
            return "\(age)岁"
        }
    }

    // Tag display text
    var tagsText: String {
        tags.map { $0.displayName }.joined(separator: " · ")
    }
}

// MARK: - Preview Data
extension Pet {
    // 6 iconic Shanghai coordinates, one-to-one with the 6 pets
    // Xiaobai → Lujiazui / Puff → The Bund / Doudou → Jing'an Temple / Bella → Xujiahui / Lucky → Century Park / Cola → Hongqiao
    static let samplePets = [
        Pet(
            ownerId: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, // Pet Owner Wang
            name: "小白",
            avatar: "小白",
            breed: .samoyed,
            age: 2,
            tags: [.friendly, .energetic, .lovesKids],
            activeTime: "上午8-10点",
            latitude: 31.2397,
            longitude: 121.4998 // Lujiazui
        ),
        Pet(
            ownerId: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, // Pet Owner Wang
            name: "泡芙",
            avatar: "泡芙",
            breed: .poodle,
            age: 3,
            tags: [.gentle, .quiet, .smart],
            activeTime: "下午4-6点",
            latitude: 31.2397,
            longitude: 121.4906 // The Bund
        ),
        Pet(
            ownerId: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!, // Cooper's Mom
            name: "豆豆",
            avatar: "豆豆",
            breed: .corgi,
            age: 1,
            tags: [.playful, .curious, .foodie],
            activeTime: "上午9-11点，下午5-7点",
            latitude: 31.2236,
            longitude: 121.4458 // Jing'an Temple
        ),
        Pet(
            ownerId: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!, // Pet doctor Li
            name: "Bella",
            avatar: "bella",
            breed: .goldenRetriever,
            age: 4,
            tags: [.friendly, .loyal, .lovesFetch],
            activeTime: "上午7-9点，下午6-8点",
            latitude: 31.1948,
            longitude: 121.4365 // Xujiahui
        ),
        Pet(
            ownerId: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!, // Shanghai Pet Circle
            name: "Lucky",
            avatar: "lucky",
            breed: .labrador,
            age: 2,
            tags: [.energetic, .goodWithDogs, .lovesWater],
            activeTime: "全天",
            latitude: 31.2155,
            longitude: 121.5471 // Century Park
        ),
        Pet(
            ownerId: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!, // Pet Supplies Reviews
            name: "可乐",
            avatar: "可乐",
            breed: .shibaInu,
            age: 3,
            tags: [.smart, .curious, .trained],
            activeTime: "上午10-12点，下午3-5点",
            latitude: 31.1972,
            longitude: 121.4007 // Hongqiao
        )
    ]
}

// MARK: - Breed Enum
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
        case .poodle: return "泰迪"
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

// MARK: - Pet Tag Enum
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
