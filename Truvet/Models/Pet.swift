//
//  Pet.swift
//  Truvet
//
//  Created by signerlabs.
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
            return "Unknown"
        } else if age == 1 {
            return "1 yr"
        } else {
            return "\(age) yrs"
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
    // Snowy → Lujiazui / Puff → The Bund / Bean → Jing'an Temple / Bella → Xujiahui / Lucky → Century Park / Cola → Hongqiao
    static let samplePets = [
        Pet(
            ownerId: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, // Alex Walker
            name: "Snowy",
            avatar: "小白",
            breed: .samoyed,
            age: 2,
            tags: [.friendly, .energetic, .lovesKids],
            activeTime: "8-10 AM",
            latitude: 31.2397,
            longitude: 121.4998 // Lujiazui
        ),
        Pet(
            ownerId: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!, // Alex Walker
            name: "Puff",
            avatar: "泡芙",
            breed: .poodle,
            age: 3,
            tags: [.gentle, .quiet, .smart],
            activeTime: "4-6 PM",
            latitude: 31.2397,
            longitude: 121.4906 // The Bund
        ),
        Pet(
            ownerId: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!, // Cooper's Mom
            name: "Bean",
            avatar: "豆豆",
            breed: .corgi,
            age: 1,
            tags: [.playful, .curious, .foodie],
            activeTime: "9-11 AM, 5-7 PM",
            latitude: 31.2236,
            longitude: 121.4458 // Jing'an Temple
        ),
        Pet(
            ownerId: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!, // Dr. Liam Chen
            name: "Bella",
            avatar: "bella",
            breed: .goldenRetriever,
            age: 4,
            tags: [.friendly, .loyal, .lovesFetch],
            activeTime: "7-9 AM, 6-8 PM",
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
            activeTime: "All day",
            latitude: 31.2155,
            longitude: 121.5471 // Century Park
        ),
        Pet(
            ownerId: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!, // Pet Gear Reviews
            name: "Cola",
            avatar: "可乐",
            breed: .shibaInu,
            age: 3,
            tags: [.smart, .curious, .trained],
            activeTime: "10 AM-12 PM, 3-5 PM",
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
        case .goldenRetriever: return "Golden Retriever"
        case .corgi: return "Corgi"
        case .husky: return "Husky"
        case .poodle: return "Poodle"
        case .labrador: return "Labrador"
        case .shibaInu: return "Shiba Inu"
        case .samoyed: return "Samoyed"
        case .chihuahua: return "Chihuahua"
        case .pomeranian: return "Pomeranian"
        case .frenchBulldog: return "French Bulldog"
        case .borderCollie: return "Border Collie"
        case .germanShepherd: return "German Shepherd"
        case .beagle: return "Beagle"
        case .mixedBreed: return "Mixed Breed"
        case .other: return "Other"
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
        case .energetic: return "Energetic"
        case .friendly: return "Friendly"
        case .gentle: return "Gentle"
        case .playful: return "Playful"
        case .quiet: return "Quiet"
        case .smart: return "Smart"
        case .loyal: return "Loyal"
        case .curious: return "Curious"
        case .shy: return "Shy"
        case .trained: return "Trained"
        case .lovesKids: return "Loves Kids"
        case .goodWithDogs: return "Dog-Friendly"
        case .lovesFetch: return "Loves Fetch"
        case .lovesWater: return "Water Lover"
        case .foodie: return "Foodie"
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
