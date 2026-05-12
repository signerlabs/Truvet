//
//  PetEditView.swift
//  Truvet
//
//  Created by signerlabs.
//

import SwiftUI

/// Pet edit view: pure mock, the Save button only dismisses
struct PetEditView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name: String
    @State private var breed: PetBreed
    @State private var age: Int
    @State private var selectedTags: Set<PetTag>
    @State private var activeTime: String
    private let avatar: String

    init(pet: Pet) {
        self._name = State(initialValue: pet.name)
        self._breed = State(initialValue: pet.breed)
        self._age = State(initialValue: pet.age)
        self._selectedTags = State(initialValue: Set(pet.tags))
        self._activeTime = State(initialValue: pet.activeTime)
        self.avatar = pet.avatar
    }

    /// Two-column grid for tag chips
    private let tagColumns = [
        GridItem(.adaptive(minimum: 90), spacing: 8)
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                avatarHeader

                VStack(alignment: .leading, spacing: 16) {
                    nameField
                    breedField
                    ageField
                    activeTimeField
                    tagsField
                }
                .padding(.horizontal, 16)

                saveButton
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
            }
            .padding(.vertical, 16)
        }
        .background(Color.background)
        .navigationTitle("编辑宠物")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Avatar Header
    private var avatarHeader: some View {
        VStack(spacing: 8) {
            Image(avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(.ultraThickMaterial, lineWidth: 3))
            Text("头像")
                .font(.system(size: 12))
                .foregroundStyle(.tertiary)
        }
    }

    // MARK: - Name
    private var nameField: some View {
        sectionContainer(title: "名字") {
            TextField("给毛孩子起个名字", text: $name)
                .font(.system(size: 15))
                .padding(.vertical, 8)
        }
    }

    // MARK: - Breed
    private var breedField: some View {
        sectionContainer(title: "品种") {
            Picker("品种", selection: $breed) {
                ForEach(PetBreed.allCases) { b in
                    Text(b.displayName).tag(b)
                }
            }
            .pickerStyle(.menu)
            .tint(Color.accent)
            .padding(.vertical, 4)
        }
    }

    // MARK: - Age
    private var ageField: some View {
        sectionContainer(title: "年龄") {
            Stepper(value: $age, in: 0...20) {
                HStack {
                    Text(age == 0 ? "未知" : "\(age) 岁")
                        .font(.system(size: 15))
                    Spacer()
                }
            }
        }
    }

    // MARK: - Active Time
    private var activeTimeField: some View {
        sectionContainer(title: "活跃时间") {
            TextField("例如：上午8-10点，下午4-6点", text: $activeTime)
                .font(.system(size: 15))
                .padding(.vertical, 8)
        }
    }

    // MARK: - Multi-select Tags
    private var tagsField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("性格标签")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)

            LazyVGrid(columns: tagColumns, alignment: .leading, spacing: 8) {
                ForEach(PetTag.allCases) { tag in
                    PetTagChip(tag: tag, isSelected: selectedTags.contains(tag)) {
                        if selectedTags.contains(tag) {
                            selectedTags.remove(tag)
                        } else {
                            selectedTags.insert(tag)
                        }
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }

    // MARK: - Save Button
    private var saveButton: some View {
        Button {
            // Pure mock: just dismiss
            dismiss()
        } label: {
            Text("保存")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Capsule().fill(Color.accent))
        }
        .buttonStyle(.plain)
    }

    // MARK: - Helper: Section Container
    @ViewBuilder
    private func sectionContainer<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
            HStack {
                content()
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 12)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemBackground)))
        }
    }
}

#Preview {
    NavigationStack {
        PetEditView(pet: Pet.samplePets[0])
    }
}
