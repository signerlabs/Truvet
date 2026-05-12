//
//  SegmentedHeader.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//

import SwiftUI

/// Xiaohongshu-style underline segmented control
/// - Supports any number of segments (generic over Hashable items)
/// - Selected underline uses matchedGeometryEffect for smooth sliding
struct SegmentedHeader<Item: Hashable>: View {
    let items: [Item]
    let title: (Item) -> String
    @Binding var selection: Item

    @Namespace private var underlineNamespace

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items, id: \.self) { item in
                let isSelected = item == selection
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
                        selection = item
                    }
                } label: {
                    VStack(spacing: 6) {
                        Text(title(item))
                            .font(.system(size: 16, weight: isSelected ? .bold : .regular))
                            .foregroundStyle(isSelected ? Color.primary : Color.secondary)
                            .padding(.horizontal, 4)

                        // Underline: selected = filled, others = clear; matchedGeometryEffect provides the slide animation
                        if isSelected {
                            Capsule()
                                .fill(Color.accent)
                                .frame(width: 24, height: 3)
                                .matchedGeometryEffect(id: "underline", in: underlineNamespace)
                        } else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(width: 24, height: 3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var selection = "发现"
        var body: some View {
            VStack {
                SegmentedHeader(
                    items: ["关注", "发现", "同城"],
                    title: { $0 },
                    selection: $selection
                )
                Text("当前：\(selection)")
                    .padding()
                Spacer()
            }
        }
    }
    return PreviewWrapper()
}
