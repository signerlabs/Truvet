# CLAUDE.md

Truvet — a pet-owner social platform iOS demo. An early scaffolding project from the [ShipSwift](https://github.com/signerlabs/ShipSwift) exploration phase, less polished than [BobaLoyalty](https://github.com/signerlabs/bobaloyalty-ios) or [TutorTrack](https://github.com/signerlabs/tutortrack-ios) — open-sourced so the community can see the *style* of code ShipSwift recipes produce when composed into a multi-screen social app.

## Read First

- [README.md](README.md) — Project info, 4-tab architecture, SwiftData model list, Getting Started, notable effects

## Engineering Constraints

- **No third-party dependencies** — pure system frameworks + local SwiftData mock
- **Every file using SwiftData APIs must `import SwiftData`** at the top
- **iOS 26.4 / Swift 5 / MainActor isolation by default**
- **Universal app** — supports both iOS and macOS targets (use `#if canImport(UIKit)` or platform-conditional `Color(.systemBackground)` patterns where needed)

## Architecture Snapshot

4-tab `TabView` (default tab = Community for instant visual impact):
- **Map** — Nearby pet sightings on MapKit annotations
- **Community** — Photo waterfall feed (default)
- **Message** — DM threads + chat
- **Profile** — Owner profile + pet edit

SwiftData models: `User` / `Pet` / `Post` / `Comment` / `ChatConversation` / `ChatMessage` / `AppNotification`. All local-only, mock data seeded on first launch.

## Project Status

This is an earlier ShipSwift demo — less complete than the polished BobaLoyalty / TutorTrack siblings, but useful as a reference for how a social-app shape gets assembled from ShipSwift recipes. See the [README](README.md) for the runnable Getting Started flow.
