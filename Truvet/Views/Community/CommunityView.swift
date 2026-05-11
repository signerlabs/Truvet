//
//  CommunityView.swift
//  Truvet
//
//  Created by 仲炜 on 2025/10/29.
//  Rewritten by 霍去病 on 2026/05/11.
//

import SwiftUI
import CoreLocation

/// 社区 Tab：顶部三段 + 双列瀑布流 + 右上角发布入口
struct CommunityView: View {
    /// 三段枚举
    enum Segment: String, CaseIterable, Hashable {
        case following = "关注"
        case discover  = "发现"
        case nearby    = "同城"
    }

    @State private var segment: Segment = .discover
    @State private var showComposer: Bool = false

    /// 上海市中心，用于"同城"段计算距离
    private let cityCenter = CLLocation(latitude: 31.2304, longitude: 121.4737)

    /// 双列网格
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // 顶部三段
                SegmentedHeader(
                    items: Segment.allCases,
                    title: { $0.rawValue },
                    selection: $segment
                )
                .background(Color(.systemBackground))

                Divider()
                    .opacity(0.4)

                // 主体：双列瀑布流
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
                    // 纯 mock：模拟下拉刷新一下网络延迟
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

    /// 根据当前段过滤数据
    private var currentPosts: [Post] {
        switch segment {
        case .following:
            // mock：仅展示前 4 篇作为"关注"
            return Array(Post.samplePosts.prefix(4))
        case .discover:
            return Post.samplePosts
        case .nearby:
            // 按距离上海市中心升序
            return Post.samplePosts.sorted { lhs, rhs in
                lhs.clLocation.distance(from: cityCenter) < rhs.clLocation.distance(from: cityCenter)
            }
        }
    }
}

// MARK: - Post 实现 Hashable（用于 navigationDestination(for:)）
extension Post: Hashable {
    static func == (lhs: Post, rhs: Post) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

#Preview {
    CommunityView()
}
