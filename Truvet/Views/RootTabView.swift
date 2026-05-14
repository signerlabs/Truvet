//
//  RootTabView.swift
//  Truvet
//
//  Created by signerlabs.
//

import SwiftUI

/// Top-level Tab router: Map / Community / Messages / Profile
/// Defaults to Community since the waterfall feed is the most intuitive first view
struct RootTabView: View {
    @State private var selectedTab: String = "community"

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Map", systemImage: "pawprint.fill", value: "map") {
                MapView()
            }

            Tab("Community", systemImage: "square.grid.2x2.fill", value: "community") {
                CommunityView()
            }

            Tab("Messages", systemImage: "bubble.left.and.bubble.right.fill", value: "message") {
                MessageView()
            }

            Tab("Me", systemImage: "person.crop.circle.fill", value: "profile") {
                ProfileView()
            }
        }
        .tint(.accent)
        .sensoryFeedback(.increase, trigger: selectedTab)
    }
}

#Preview {
    RootTabView()
}
