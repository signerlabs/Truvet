//
//  PostComposerView.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//

import SwiftUI

/// 发布动态：纯 mock，"发布"按钮只 dismiss
struct PostComposerView: View {
    @Environment(\.dismiss) private var dismiss

    /// 6 张可选图（来自 dogs Asset）
    private let candidateImages = ["bella", "lucky", "豆豆", "可乐", "小白", "泡芙"]

    @State private var selectedImages: Set<String> = []
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedPetId: UUID? = nil
    @State private var locationOn: Bool = false
    @State private var selectedTopics: Set<String> = []

    private let recommendedTopics = ["#遛狗日常", "#宠物生活", "#同城聚会"]

    /// 我的宠物
    private var myPets: [Pet] {
        Pet.samplePets.filter { $0.ownerId == User.currentUser.id }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    imagePicker
                    titleField
                    contentField
                    petPicker
                    locationRow
                    topicsRow
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            .background(Color.background)
            .navigationTitle("发布动态")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("取消") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // 纯 mock：直接关闭
                        dismiss()
                    } label: {
                        Text("发布")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Capsule().fill(Color.accent))
                    }
                }
            }
        }
    }

    // MARK: - 选图区
    private var imagePicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("选择图片")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.secondary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(candidateImages, id: \.self) { name in
                        let isOn = selectedImages.contains(name)
                        Button {
                            if isOn {
                                selectedImages.remove(name)
                            } else {
                                selectedImages.insert(name)
                            }
                        } label: {
                            ZStack(alignment: .topTrailing) {
                                Image(name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 88, height: 88)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(isOn ? Color.accent : Color.clear, lineWidth: 2)
                                    )
                                if isOn {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 18))
                                        .foregroundStyle(.white, Color.accent)
                                        .padding(4)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    // MARK: - 标题
    private var titleField: some View {
        TextField("好标题更容易被推荐", text: $title)
            .font(.system(size: 18, weight: .bold))
            .padding(.vertical, 6)
    }

    // MARK: - 正文
    private var contentField: some View {
        ZStack(alignment: .topLeading) {
            if content.isEmpty {
                Text("分享和宠物的故事...")
                    .font(.system(size: 15))
                    .foregroundStyle(.tertiary)
                    .padding(.top, 8)
                    .padding(.leading, 5)
            }
            TextEditor(text: $content)
                .font(.system(size: 15))
                .frame(minHeight: 140)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
        }
    }

    // MARK: - 关联宠物
    @ViewBuilder
    private var petPicker: some View {
        if myPets.isEmpty {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 10) {
                Text("关联宠物")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.secondary)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(myPets) { pet in
                            let isOn = selectedPetId == pet.id
                            Button {
                                selectedPetId = isOn ? nil : pet.id
                            } label: {
                                VStack(spacing: 4) {
                                    Image(pet.avatar)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .strokeBorder(isOn ? Color.accent : Color.clear, lineWidth: 2)
                                        )
                                    Text(pet.name)
                                        .font(.system(size: 12, weight: isOn ? .semibold : .regular))
                                        .foregroundStyle(isOn ? Color.accent : Color.primary)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }

    // MARK: - 添加位置
    private var locationRow: some View {
        Button {
            withAnimation { locationOn.toggle() }
        } label: {
            HStack {
                Image(systemName: locationOn ? "mappin.circle.fill" : "mappin.circle")
                    .font(.system(size: 18))
                    .foregroundStyle(locationOn ? Color.accent : .secondary)
                Text(locationOn ? "上海·世纪公园" : "添加位置")
                    .font(.system(size: 14))
                    .foregroundStyle(locationOn ? Color.accent : .primary)
                Spacer()
                if !locationOn {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundStyle(.tertiary)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
        }
        .buttonStyle(.plain)
    }

    // MARK: - 话题
    private var topicsRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("推荐话题")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 8) {
                ForEach(recommendedTopics, id: \.self) { topic in
                    TopicChip(text: topic, isSelected: selectedTopics.contains(topic)) {
                        if selectedTopics.contains(topic) {
                            selectedTopics.remove(topic)
                        } else {
                            selectedTopics.insert(topic)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PostComposerView()
}
