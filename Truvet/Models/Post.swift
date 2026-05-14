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
    let images: [String] // Array of image URLs
    let title: String // Title
    let content: String // Body content
    let likeCount: Int // Number of likes
    let commentCount: Int // Number of comments
    let user: User // Author info - a Post belongs to exactly one User
    let tags: [String] // Topic tags
    let createdAt: Date // Publish time
    var latitude: Double = 0.0
    var longitude: Double  = 0.0

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}

// MARK: - Preview Data
extension Post {
    static let samplePosts = [
        Post(
            id: UUID(uuidString: "11111111-0000-0000-0000-000000000001")!,
            images: ["bella", "小白", "lucky"],
            title: "Park day with the pups!",
            content: "The weather was perfect today, so I took my babies out for a walk in the park. They had so much fun! #DailyWalks Sunny weekends are made for getting the fur kids some fresh air 💕",
            likeCount: 1234,
            commentCount: 89,
            user: User.sampleUsers[0], // Alex Walker
            tags: ["DailyWalks", "Dogs", "PetLife"],
            createdAt: Date().addingTimeInterval(-3600),
            latitude: 31.2219,
            longitude: 121.5383
        ),
        Post(
            id: UUID(uuidString: "11111111-0000-0000-0000-000000000002")!,
            images: ["豆豆"],
            title: "New trick unlocked! Handshake 🐾",
            content: "After two weeks of training, Bean finally learned how to shake! Every time I bring out a treat she sticks out her little paw — so cute. Any training tips from fellow pet parents?",
            likeCount: 892,
            commentCount: 56,
            user: User.sampleUsers[1], // Cooper's Mom
            tags: ["DogTraining", "PetTricks", "DailyLife"],
            createdAt: Date().addingTimeInterval(-7200),
            latitude: 31.2304,
            longitude: 121.4737
        ),
        Post(
            id: UUID(uuidString: "11111111-0000-0000-0000-000000000003")!,
            images: ["可乐", "bella"],
            title: "Annual checkup at the vet 📋",
            content: "Took Cola and Bella in for their yearly checkup today — both dogs are in great shape! The vet said their weight is on point. Friendly reminder to schedule annual checkups for your fur kids too.",
            likeCount: 2156,
            commentCount: 134,
            user: User.sampleUsers[2], // Dr. Liam Chen
            tags: ["PetHealth", "VetVisit", "PetLife"],
            createdAt: Date().addingTimeInterval(-14400),
            latitude: 31.2020,
            longitude: 121.4985
        ),
        Post(
            id: UUID(uuidString: "11111111-0000-0000-0000-000000000004")!,
            images: ["泡芙", "豆豆", "可乐"],
            title: "Weekend doggie meetup 🎉",
            content: "Hosted a small dog meetup this weekend — three little cuties had the absolute best time! Played from morning till afternoon and went home to crash 😴 Any Shanghai pet parents want to organize the next one?",
            likeCount: 3421,
            commentCount: 287,
            user: User.sampleUsers[3], // Shanghai Pet Circle
            tags: ["DogMeetup", "PetSocial", "Shanghai"],
            createdAt: Date().addingTimeInterval(-21600),
            latitude: 31.1843,
            longitude: 121.5219
        ),
        Post(
            id: UUID(uuidString: "11111111-0000-0000-0000-000000000005")!,
            images: ["小白", "bella"],
            title: "Dog food review — this one's a winner!",
            content: "Recently tried this new natural dog food and Snowy and Bella are obsessed! The nutrition profile is solid and their coats are noticeably shinier. Sharing in case you're shopping around — link in the comments.",
            likeCount: 567,
            commentCount: 42,
            user: User.sampleUsers[4], // Pet Gear Reviews
            tags: ["FoodReview", "PetGear", "MustHave"],
            createdAt: Date().addingTimeInterval(-28800),
            latitude: 31.1956,
            longitude: 121.4310
        ),
        Post(
            id: UUID(uuidString: "11111111-0000-0000-0000-000000000006")!,
            images: ["lucky"],
            title: "Lucky's rescue story ❤️",
            content: "I found Lucky a month ago, wandering near my apartment — skin and bones. After weeks of care he's healthy again, and I've officially decided to adopt him 💕 Adopt, don't shop.",
            likeCount: 8923,
            commentCount: 456,
            user: User.sampleUsers[5], // Stray Rescue HQ
            tags: ["StrayRescue", "Adoption", "DoGood"],
            createdAt: Date().addingTimeInterval(-43200),
            latitude: 31.2165,
            longitude: 121.4451
        )
    ]
}
