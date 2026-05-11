//
//  SegmentedHeader.swift
//  Truvet
//
//  Created by 霍去病 on 2026/05/11.
//

import SwiftUI

/// 小红书风格的下划线 segmented 控件
/// - 支持任意数量段（用 LabelsAreEquatable 约束泛型）
/// - 选中下划线用 matchedGeometryEffect 做平滑滑动
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

                        // 下划线：选中段渲染实色，未选中段渲染透明，靠 matchedGeometryEffect 实现滑动
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
