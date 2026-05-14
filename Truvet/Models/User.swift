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
            username: "Alex Walker",
            avatar: "铲屎官小王",
            isVerified: true,
            bio: "Veteran pet parent | Three dogs at home | Sharing daily pet life"
        ),
        User(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
            username: "Cooper's Mom",
            avatar: "Cooper的麻麻",
            isVerified: false,
            bio: "Cooper's mom | New puppy parent | Documenting every milestone"
        ),
        User(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
            username: "Dr. Liam Chen",
            avatar: "宠物医生小李",
            isVerified: true,
            bio: "Licensed veterinarian | 10+ years of clinical experience | Health Q&A"
        ),
        User(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
            username: "Shanghai Pet Circle",
            avatar: "上海宠物圈",
            isVerified: true,
            bio: "Shanghai's most active pet community | Hosting offline meetups"
        ),
        User(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
            username: "Pet Gear Reviews",
            avatar: "宠物用品测评",
            isVerified: true,
            bio: "Honest reviews | Must-have picks | What to avoid"
        ),
        User(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000006")!,
            username: "Stray Rescue HQ",
            avatar: "流浪动物救助",
            isVerified: true,
            bio: "Nonprofit | Rescuing stray animals | Adopt, don't shop"
        )
    ]
}

// MARK: - Current Logged-in User (pure mock)
extension User {
    /// "Me" in the demo, defaults to the first sample user
    static var currentUser: User { sampleUsers[0] }
}

