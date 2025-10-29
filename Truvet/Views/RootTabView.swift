//
//  RootTabView.swift
//  Truvet
//
//  Created by 仲炜 on 2025/10/29.
//

import SwiftUI

struct RootTabView: View {
    @State private var selectedTab = "map"

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("", systemImage: "map", value: "map") {
                MapView()
            }
            
            Tab("", systemImage: "bubble", value: "community") {
                CommunityView()
            }
            
            Tab("", systemImage: "bag", value: "shop") {
                ShopView()
            }
            
            Tab("", systemImage: "bell", value: "message") {
                MessageView()
            }
            
            Tab("", systemImage: "person", value: "profile") {
                ProfileView()
            }
        }
        .sensoryFeedback(.increase, trigger: selectedTab)
    }
}

#Preview {
    RootTabView()
}
