//
//  ChatMessage.swift
//  Truvet
//
//  Created by signerlabs.
//

import Foundation

// MARK: - Chat Message Model
struct ChatMessage: Identifiable, Codable, Equatable {
    let id: UUID
    let conversationId: UUID
    let content: String
    let isFromMe: Bool
    let createdAt: Date
}

// MARK: - Mock Message Generator
extension ChatMessage {
    /// One conversation script per conversation (5-10 messages, bidirectional)
    /// Note: returned messages are sorted ascending by createdAt for UI display
    static func samples(for conversationId: UUID) -> [ChatMessage] {
        let scripts: [String: [(String, Bool)]] = [
            // Cooper's Mom
            "22222222-0000-0000-0000-000000000001": [
                ("You there?", false),
                ("Yep, what's up", true),
                ("Want to walk the dogs tomorrow afternoon?", false),
                ("The Bund's gonna be crowded though", true),
                ("Century Park is great, lots of dog folks there too", false),
                ("Sure! What time?", true),
                ("3 PM at the south gate", false),
                ("Got it, see you tomorrow!", true),
                ("Walk along the Bund tomorrow afternoon?", false)
            ],
            // Dr. Liam Chen
            "22222222-0000-0000-0000-000000000002": [
                ("Hi doc, my dog hasn't had much appetite lately", true),
                ("Any change in weather or new food recently?", false),
                ("No new food. It's been getting colder though", true),
                ("Watch for 24-48 hours, check overall energy levels", false),
                ("If vomiting or diarrhea kicks in, head to the clinic", false),
                ("Got it, thank you doctor", true),
                ("Just DM'd you, check your inbox!", false)
            ],
            // Shanghai Pet Circle
            "22222222-0000-0000-0000-000000000003": [
                ("Hey there, been following you for a while!", true),
                ("Welcome welcome!", false),
                ("Saw your meetups — would love to join one", true),
                ("Next one is at Century Park south gate", false),
                ("My dog eats that same food and loves it", false),
                ("Same here, great value for the price", true)
            ],
            // Pet Gear Reviews
            "22222222-0000-0000-0000-000000000004": [
                ("Hey, does that probiotic actually work?", true),
                ("Mine have been on it for months, works great", false),
                ("Appetite and bathroom schedule both improved", false),
                ("Cool, gonna grab one", true),
                ("Any spots left for the Saturday meetup?", false),
                ("Yep, come on through!", true)
            ],
            // Stray Rescue HQ
            "22222222-0000-0000-0000-000000000005": [
                ("Hi, can you walk me through the adoption process?", true),
                ("First a questionnaire, then a volunteer home visit", false),
                ("If the home visit passes, you take your new buddy home!", false),
                ("Got it, where do I find the questionnaire?", true),
                ("Sending you the link via DM", false),
                ("Thanks for sharing — saved it!", true)
            ],
            // 6th conversation (placeholder, uses one of the users)
            "22222222-0000-0000-0000-000000000006": [
                ("I spotted your Snowy!", false),
                ("Haha yep, 2-year-old Samoyed", true),
                ("That coat is unreal", false),
                ("Brushing him is a full-time job 🥲", true),
                ("Snowy is just too cute!", false)
            ]
        ]

        let key = conversationId.uuidString.lowercased()
        // Note: UUIDs in uppercase need to be lowercased to match dictionary keys
        let normalizedScripts = Dictionary(uniqueKeysWithValues:
            scripts.map { ($0.key.lowercased(), $0.value) }
        )
        let script = normalizedScripts[key] ?? []

        // Convert the script into time-ordered messages; the last one is ~5 min ago, each earlier one 8 min before it
        let now = Date()
        let total = script.count
        return script.enumerated().map { i, item in
            let (text, isFromMe) = item
            // When i = total - 1 this is the most recent message, closest to now
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
