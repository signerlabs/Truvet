//
//  CommunityView.swift
//  Truvet
//
//  Created by 仲炜 on 2025/10/29.
//

import SwiftUI

struct CommunityView: View {
    var body: some View {
        VStack {
            AppleLoginAnimation(logo: "TabIcon",
                                images: ["豆豆", "泡芙", "小白", "可乐", "bella", "lucky"])
        }
        .background(Color.background)
    }
}

#Preview {
    CommunityView()
}
