<div align="center">

### ⭐ Built with [**ShipSwift**](https://github.com/signerlabs/ShipSwift) — the open-source Swift skill library for vibe-coding iOS apps

**If this demo is useful to you, please [give ShipSwift a ⭐ on GitHub](https://github.com/signerlabs/ShipSwift).**
*Stars on the main repo are what keep this whole library moving.*

[![Star ShipSwift on GitHub](https://img.shields.io/github/stars/signerlabs/ShipSwift?style=for-the-badge&logo=github&label=Star%20ShipSwift&color=FFD700)](https://github.com/signerlabs/ShipSwift)

</div>

---

# Truvet

> A pet-owner social app demo — early experimental scaffold built with [ShipSwift](https://github.com/signerlabs/ShipSwift) components.

Single iOS app for pet owners: discover nearby pets on a map, share photo posts in a feed, message other owners, and manage your own pet profile. In-memory mock data only — no backend, no API keys, clone & run.

This is an earlier scaffolding project (less polished than [BobaLoyalty](https://github.com/signerlabs/bobaloyalty-ios) or [TutorTrack](https://github.com/signerlabs/tutortrack-ios)) — open-sourced as a reference for the *kind* of app shape that ShipSwift makes easy to assemble.

---

## Project Info

| Field | Value |
|---|---|
| Bundle ID | `com.signerlabs.Truvet` |
| Team ID | `5GS4D3667R` |
| iOS Deployment Target | 18.0 (iPhone only) |
| Swift | 5.0 (MainActor isolation by default) |
| Xcode project layout | `PBXFileSystemSynchronizedRootGroup` — new `.swift` files auto-sync into the build target |
| Backend | None (in-memory mock data only) |
| Third-party deps | None |

---

## 4-Tab Architecture

```
TruvetApp
└─ RootTabView
    ├─ Map        MapView          (Views/Map/)         — Nearby pet sightings
    ├─ Community  CommunityView    (Views/Community/)   — Feed of pet photos / posts (default tab)
    ├─ Messages   MessageView      (Views/Message/)     — Direct messages / conversations
    └─ Me         ProfileView      (Views/Profile/)     — Owner profile + pet edit
```

The default tab is **Community** — a photo waterfall is the most visually compelling first screen.

---

## Models

| Model | Purpose |
|---|---|
| `User` | App user (pet owner) |
| `Pet` | A single pet attached to a user (name, breed, age, tags, location) |
| `Post` | Community feed post (title + text + images + likes) |
| `Comment` | Comments under a post |
| `ChatConversation` | A 1:1 conversation thread between two users |
| `ChatMessage` | Single message inside a conversation |
| `AppNotification` | In-app notification (like, comment, follow, system) |

All models are plain `Codable` structs with built-in sample data — nothing is persisted.

---

## Getting Started

```bash
git clone https://github.com/signerlabs/Truvet.git
cd Truvet
open Truvet.xcodeproj
```

In Xcode:

1. Select iPhone 17 Pro Simulator (or any iPhone on iOS 18.0+)
2. `Cmd+R` to run
3. Built-in sample pets / posts / chats give every tab something to show

No API keys required. No accounts. Pure in-memory mock data.

---

## Notable Effects

- **Apple-style rotating logo animation** (`AppleLoginAnimation`, SpriteKit; easing curves in `SKTimingFunctions.swift`) — a standalone component with an Xcode preview, not wired into the app flow
- **Map view** with annotated pet sightings using MapKit
- **Community waterfall** layout for photo posts

---

## Built with Claude Code + ShipSwift

This project was scaffolded as part of an early ShipSwift exploration — it's less prescriptive than the polished [BobaLoyalty](https://github.com/signerlabs/bobaloyalty-ios) and [TutorTrack](https://github.com/signerlabs/tutortrack-ios) demos. It's open-sourced so the community can see the *style* of code ShipSwift skills produce when composed into a multi-screen social app.

- ShipSwift main repo: [signerlabs/ShipSwift](https://github.com/signerlabs/ShipSwift)
- More polished demos: [BobaLoyalty](https://github.com/signerlabs/bobaloyalty-ios), [TutorTrack](https://github.com/signerlabs/tutortrack-ios)

---

## License

MIT — see [LICENSE](LICENSE).
