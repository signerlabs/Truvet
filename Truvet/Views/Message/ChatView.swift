//
//  ChatView.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//

import SwiftUI

/// 一对一聊天视图：纯 mock
struct ChatView: View {
    let conversation: ChatConversation

    @State private var messages: [ChatMessage] = []
    @State private var draft: String = ""
    @FocusState private var inputFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            // 消息列表
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(Array(messages.enumerated()), id: \.element.id) { index, msg in
                            // 与上一条消息相隔超过 5 分钟才显示时间分隔
                            if shouldShowTimeDivider(at: index) {
                                ChatTimeDivider(date: msg.createdAt)
                            }
                            ChatBubble(message: msg, otherAvatar: conversation.otherUser.avatar)
                                .id(msg.id)
                        }
                        // 底部锚点，方便发送新消息时滚动
                        Color.clear.frame(height: 1).id("BOTTOM")
                    }
                    .padding(.vertical, 12)
                }
                .background(Color.background)
                .onChange(of: messages.count) { _, _ in
                    withAnimation(.easeOut(duration: 0.25)) {
                        proxy.scrollTo("BOTTOM", anchor: .bottom)
                    }
                }
                .onAppear {
                    // 首次进入直接定位到底部
                    DispatchQueue.main.async {
                        proxy.scrollTo("BOTTOM", anchor: .bottom)
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            inputBar
        }
        .navigationTitle(conversation.otherUser.username)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // 首次加载 mock 历史消息
            if messages.isEmpty {
                messages = ChatMessage.samples(for: conversation.id)
            }
        }
    }

    // MARK: - 输入栏
    private var inputBar: some View {
        HStack(spacing: 10) {
            HStack {
                TextField("发条消息...", text: $draft, axis: .vertical)
                    .font(.system(size: 15))
                    .lineLimit(1...4)
                    .focused($inputFocused)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(RoundedRectangle(cornerRadius: 18).fill(Color(.systemGray6)))

            Button {
                sendMessage()
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Capsule().fill(draft.trimmingCharacters(in: .whitespaces).isEmpty ? Color.gray.opacity(0.4) : Color.accent))
            }
            .buttonStyle(.plain)
            .disabled(draft.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
        .overlay(alignment: .top) {
            Divider().opacity(0.5)
        }
    }

    // MARK: - 发送
    private func sendMessage() {
        let text = draft.trimmingCharacters(in: .whitespaces)
        guard !text.isEmpty else { return }
        let new = ChatMessage(
            id: UUID(),
            conversationId: conversation.id,
            content: text,
            isFromMe: true,
            createdAt: Date()
        )
        messages.append(new)
        draft = ""
    }

    /// 判断当前位置是否需要插入时间分隔
    private func shouldShowTimeDivider(at index: Int) -> Bool {
        guard index < messages.count else { return false }
        if index == 0 { return true }
        let prev = messages[index - 1]
        let curr = messages[index]
        return curr.createdAt.timeIntervalSince(prev.createdAt) >= 5 * 60
    }
}

#Preview {
    NavigationStack {
        ChatView(conversation: ChatConversation.sampleConversations[0])
    }
}
