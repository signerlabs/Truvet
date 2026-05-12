//
//  ProfileView.swift
//  Truvet
//
//  Created by signerlabs.
//

import SwiftUI

/// Profile Tab: user info + my pets + my posts
struct ProfileView: View {
    private let user = User.currentUser

    /// Two-column grid
    private let postColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    /// My pets
    private var myPets: [Pet] {
        Pet.samplePets.filter { $0.ownerId == user.id }
    }

    /// My posts
    private var myPosts: [Post] {
        Post.samplePosts.filter { $0.user.id == user.id }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    headerSection
                    Divider().opacity(0.4)
                    petsSection
                    Divider().opacity(0.4)
                    myPostsSection
                }
                .padding(.bottom, 24)
            }
            .background(Color.background)
            .navigationTitle("我")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // Placeholder: future settings navigation
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.primary)
                    }
                }
            }
            .navigationDestination(for: Pet.self) { pet in
                PetEditView(pet: pet)
            }
            .navigationDestination(for: Post.self) { post in
                PostDetailView(post: post)
            }
        }
    }

    // MARK: - Header
    private var headerSection: some View {
        VStack(spacing: 12) {
            Image(user.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(Circle().stroke(.ultraThickMaterial, lineWidth: 3))

            HStack(spacing: 6) {
                Text(user.username)
                    .font(.title3)
                    .fontWeight(.bold)
                if user.isVerified {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(Color.accent)
                }
            }

            if let bio = user.bio, !bio.isEmpty {
                Text(bio)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            // Stats area
            HStack(spacing: 0) {
                statItem(value: "168", label: "关注")
                Divider().frame(height: 20)
                statItem(value: "2.3k", label: "粉丝")
                Divider().frame(height: 20)
                statItem(value: "15.6k", label: "获赞")
            }
            .padding(.top, 4)
        }
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }

    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 17, weight: .bold))
            Text(label)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - My Pets
    private var petsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("我的宠物")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Button("管理") {
                    // Placeholder
                }
                .font(.system(size: 14))
                .foregroundStyle(Color.accent)
            }
            .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(myPets) { pet in
                        NavigationLink(value: pet) {
                            petCard(pet)
                        }
                        .buttonStyle(.plain)
                    }
                    addPetCard
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private func petCard(_ pet: Pet) -> some View {
        VStack(spacing: 8) {
            Image(pet.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 76, height: 76)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.systemGray5), lineWidth: 1))

            Text(pet.name)
                .font(.system(size: 13, weight: .semibold))
                .lineLimit(1)

            Text(pet.breed.displayName)
                .font(.system(size: 11))
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .frame(width: 92)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.systemBackground))
        )
    }

    private var addPetCard: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [4]))
                    .frame(width: 76, height: 76)
                    .foregroundStyle(Color(.systemGray3))
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .foregroundStyle(Color(.systemGray2))
            }
            Text("添加宠物")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.secondary)
            Text(" ")
                .font(.system(size: 11)) // Placeholder for alignment
        }
        .frame(width: 92)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .strokeBorder(Color(.systemGray5), style: StrokeStyle(lineWidth: 1, dash: [5]))
        )
    }

    // MARK: - My Posts
    private var myPostsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("我的帖子")
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 16)

            if myPosts.isEmpty {
                Text("还没有发布过帖子～")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
            } else {
                LazyVGrid(columns: postColumns, spacing: 12) {
                    ForEach(myPosts) { post in
                        NavigationLink(value: post) {
                            PostCard(post: post)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 12)
            }
        }
        // ProfileView registers its own Post navigation, reusing PostDetailView
        .background(
            // Note: navigationDestination must be attached to an ancestor; to avoid conflicting with Pet, place it on the outer view
            Color.clear
        )
    }
}

// MARK: - Pet conforms to Hashable (for navigationDestination(for:))
extension Pet: Hashable {
    static func == (lhs: Pet, rhs: Pet) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

#Preview {
    ProfileView()
}
