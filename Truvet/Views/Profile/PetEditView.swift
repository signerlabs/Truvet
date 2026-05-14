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
        .navigationTitle("Edit Pet")
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
            Text("Avatar")
                .font(.system(size: 12))
                .foregroundStyle(.tertiary)
        }
    }

    // MARK: - Name
    private var nameField: some View {
        sectionContainer(title: "Name") {
            TextField("Give your fur kid a name", text: $name)
                .font(.system(size: 15))
                .padding(.vertical, 8)
        }
    }

    // MARK: - Breed
    private var breedField: some View {
        sectionContainer(title: "Breed") {
            Picker("Breed", selection: $breed) {
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
        sectionContainer(title: "Age") {
            Stepper(value: $age, in: 0...20) {
                HStack {
                    Text(age == 0 ? "Unknown" : (age == 1 ? "1 yr" : "\(age) yrs"))
                        .font(.system(size: 15))
                    Spacer()
                }
            }
        }
    }

    // MARK: - Active Time
    private var activeTimeField: some View {
        sectionContainer(title: "Active Hours") {
            TextField("e.g. 8-10 AM, 4-6 PM", text: $activeTime)
                .font(.system(size: 15))
                .padding(.vertical, 8)
        }
    }

    // MARK: - Multi-select Tags
    private var tagsField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Personality Tags")
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
            Text("Save")
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
