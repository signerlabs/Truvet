//
//  PostComposerView.swift
//  Truvet
//
//  Created by signerlabs.
//

import SwiftUI

/// Post composer: pure mock, the Publish button only dismisses
struct PostComposerView: View {
    @Environment(\.dismiss) private var dismiss

    /// 6 candidate images (from dog assets)
    private let candidateImages = ["bella", "lucky", "豆豆", "可乐", "小白", "泡芙"]

    @State private var selectedImages: Set<String> = []
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedPetId: UUID? = nil
    @State private var locationOn: Bool = false
    @State private var selectedTopics: Set<String> = []

    private let recommendedTopics = ["#DailyWalks", "#PetLife", "#LocalMeetups"]

    /// My pets
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
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Pure mock: just dismiss
                        dismiss()
                    } label: {
                        Text("Publish")
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

    // MARK: - Image Picker
    private var imagePicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Choose Photos")
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

    // MARK: - Title
    private var titleField: some View {
        TextField("A catchy title gets more reach", text: $title)
            .font(.system(size: 18, weight: .bold))
            .padding(.vertical, 6)
    }

    // MARK: - Body
    private var contentField: some View {
        ZStack(alignment: .topLeading) {
            if content.isEmpty {
                Text("Share a story about your pet...")
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

    // MARK: - Associated Pet
    @ViewBuilder
    private var petPicker: some View {
        if myPets.isEmpty {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 10) {
                Text("Tag a Pet")
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

    // MARK: - Add Location
    private var locationRow: some View {
        Button {
            withAnimation { locationOn.toggle() }
        } label: {
            HStack {
                Image(systemName: locationOn ? "mappin.circle.fill" : "mappin.circle")
                    .font(.system(size: 18))
                    .foregroundStyle(locationOn ? Color.accent : .secondary)
                Text(locationOn ? "Shanghai · Century Park" : "Add Location")
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

    // MARK: - Topics
    private var topicsRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Suggested Topics")
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
