//
//  PetTagChip.swift
//  Truvet
//
//  Created by signerlabs.
//

import SwiftUI

/// Pet tag chip with selected state, reused by PetEdit / Composer / Detail
struct PetTagChip: View {
    let tag: PetTag
    let isSelected: Bool
    var onTap: (() -> Void)? = nil

    var body: some View {
        Button {
            onTap?()
        } label: {
            HStack(spacing: 4) {
                Text(tag.emoji)
                Text(tag.displayName)
                    .font(.system(size: 13, weight: .medium))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(isSelected ? Color.accent.opacity(0.18) : Color(.systemGray6))
            )
            .overlay(
                Capsule()
                    .strokeBorder(isSelected ? Color.accent : Color.clear, lineWidth: 1)
            )
            .foregroundStyle(isSelected ? Color.accent : Color.primary)
        }
        .buttonStyle(.plain)
    }
}

/// Plain text chip (topics, locations, etc.)
struct TopicChip: View {
    let text: String
    let isSelected: Bool
    var onTap: (() -> Void)? = nil

    var body: some View {
        Button {
            onTap?()
        } label: {
            Text(text)
                .font(.system(size: 13, weight: .medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.accent.opacity(0.18) : Color(.systemGray6))
                )
                .overlay(
                    Capsule()
                        .strokeBorder(isSelected ? Color.accent : Color.clear, lineWidth: 1)
                )
                .foregroundStyle(isSelected ? Color.accent : Color.primary)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 12) {
        HStack {
            PetTagChip(tag: .friendly, isSelected: true)
            PetTagChip(tag: .energetic, isSelected: false)
            PetTagChip(tag: .quiet, isSelected: false)
        }
        HStack {
            TopicChip(text: "#遛狗日常", isSelected: true)
            TopicChip(text: "#宠物生活", isSelected: false)
        }
    }
    .padding()
}
