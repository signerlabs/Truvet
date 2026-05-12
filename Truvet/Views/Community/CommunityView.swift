//
//  CommunityView.swift
//  Truvet
//
//  Created by signerlabs.
//

import SwiftUI
import CoreLocation

/// Community Tab: three top segments + two-column waterfall feed + top-right compose entry
struct CommunityView: View {
    /// Segment enum
    enum Segment: String, CaseIterable, Hashable {
        case following = "关注"
        case discover  = "发现"
        case nearby    = "同城"
    }

    @State private var segment: Segment = .discover
    @State private var showComposer: Bool = false

    /// Downtown Shanghai, used by the "nearby" segment to compute distance
    private let cityCenter = CLLocation(latitude: 31.2304, longitude: 121.4737)

    /// Two-column grid
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Top three segments
                SegmentedHeader(
                    items: Segment.allCases,
                    title: { $0.rawValue },
                    selection: $segment
                )
                .background(Color(.systemBackground))

                Divider()
                    .opacity(0.4)

                // Body: two-column waterfall feed
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(currentPosts) { post in
                            NavigationLink(value: post) {
                                PostCard(post: post)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                }
                .refreshable {
                    // Pure mock: simulate pull-to-refresh network latency
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                }
                .background(Color.background)
            }
            .navigationTitle("社区")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showComposer = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.primary)
                    }
                }
            }
            .navigationDestination(for: Post.self) { post in
                PostDetailView(post: post)
            }
            .sheet(isPresented: $showComposer) {
                PostComposerView()
            }
        }
    }

    /// Filter posts based on the current segment
    private var currentPosts: [Post] {
        switch segment {
        case .following:
            // Mock: only show the first 4 posts as "Following"
            return Array(Post.samplePosts.prefix(4))
        case .discover:
            return Post.samplePosts
        case .nearby:
            // Sort ascending by distance to downtown Shanghai
            return Post.samplePosts.sorted { lhs, rhs in
                lhs.clLocation.distance(from: cityCenter) < rhs.clLocation.distance(from: cityCenter)
            }
        }
    }
}

// MARK: - Post conforms to Hashable (for navigationDestination(for:))
extension Post: Hashable {
    static func == (lhs: Post, rhs: Post) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

#Preview {
    CommunityView()
}
