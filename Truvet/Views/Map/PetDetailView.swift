//
//  PetDetailView.swift
//  Truvet
//
//  Created by Wei on 2025/10/30.
//

import SwiftUI

// MARK: - 宠物详情弹窗
struct PetDetailView: View {
    let pet: Pet
    
    // 双列布局配置
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 18) {
                    //MARK: 基本信息
                    VStack(spacing: 12) {
                        Image(pet.avatar)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(.ultraThickMaterial, lineWidth: 4)
                            )
                        
                        Text(pet.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 20) {
                            Label(
                                "\(pet.breed.displayName) | \(pet.ageDescription)",
                                systemImage: "pawprint.fill"
                            )
                            if !pet.activeTime.isEmpty {
                                Label(pet.activeTime, systemImage: "door.left.hand.open")
                            }
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        
                        //MARK: 性格标签
                        if !pet.tags.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        ForEach(pet.tags) { tag in
                                            HStack(spacing: 4) {
                                                Text(tag.emoji)
                                                Text(tag.displayName)
                                            }
                                            .font(.subheadline)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(.ultraThickMaterial)
                                            .foregroundStyle(.accent)
                                            .cornerRadius(8)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Divider()
                    
                    // 互动按钮
                    VStack(spacing: 12) {
                        Button {
                            // TODO: 一键邀玩功能
                        } label: {
                            HStack {
                                Image(systemName: "figure.walk")
                                    .font(.title3)
                                Text("一键邀玩")
                                    .font(.headline)
                            }
                            .padding(.vertical, 2)
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        HStack(spacing: 12) {
                            Button {
                                // TODO: 添加好友功能
                            } label: {
                                HStack {
                                    Image(systemName: "person.badge.plus")
                                    Text("添加好友")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                                .padding(.vertical, 2)
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                            
                            Button {
                                // TODO: 聊天功能
                            } label: {
                                HStack {
                                    Image(systemName: "message.fill")
                                    Text("聊天")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                                .padding(.vertical, 2)
                                .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    
                    Divider()
                    
                    // MARK: 帖子
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(Post.samplePosts) { post in
                            PostCard(post: post)
                        }
                    }
                }
                .padding()
                .padding(.vertical)
            }
            .background(Color.background)
        }
    }
}

#Preview {
    PetDetailView(pet: Pet.samplePets[1])
}
