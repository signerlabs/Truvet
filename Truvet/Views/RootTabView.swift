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
            Tab("地图", systemImage: "pawprint.fill", value: "map") {
                MapView()
            }

            Tab("社区", systemImage: "square.grid.2x2.fill", value: "community") {
                CommunityView()
            }

            Tab("消息", systemImage: "bubble.left.and.bubble.right.fill", value: "message") {
                MessageView()
            }

            Tab("我", systemImage: "person.crop.circle.fill", value: "profile") {
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
