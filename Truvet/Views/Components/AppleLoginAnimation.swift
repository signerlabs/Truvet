//
//  AppleLoginAnimation.swift
//  Truvet
//
//  Created by signerlabs.
//

import SwiftUI

struct AppleLoginAnimation: View {
    let logo: String
    let images: [String]
    
    var body: some View {
        ZStack {
            AnimatedLogoOrbit(
                images: images
            )
            
            Image(logo)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .offset(x: 0, y: -5)
        }
        .ignoresSafeArea()
        .padding()
    }
}

#Preview {
    AppleLoginAnimation(
        logo: "TabIcon",
        images: ["豆豆", "泡芙", "小白", "可乐", "bella", "lucky"]
    )
}
