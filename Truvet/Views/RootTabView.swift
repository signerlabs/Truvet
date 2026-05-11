//
//  RootTabView.swift
//  Truvet
//
//  Created by 仲炜 on 2025/10/29.
//

import SwiftUI

/// 一级 Tab 路由：地图 / 社区 / 消息 / 我
/// 默认进入社区，瀑布流第一眼最直观
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
