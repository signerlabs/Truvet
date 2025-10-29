//
//  MapView.swift
//  Truvet
//
//  Created by 仲炜 on 2025/10/29.
//

import SwiftUI
import MapKit

struct MapView: View {
    let pets = [
        Pet(
            name: "小白",
            avatar: "小白",
            breed: .samoyed,
            age: 2,
            tags: [.friendly, .energetic, .lovesKids],
            activeTime: "上午8-10点",
            latitude: 39.9,
            longitude: 116.5
        ),
        Pet(
            name: "泡芙",
            avatar: "泡芙",
            breed: .poodle,
            age: 3,
            tags: [.gentle, .quiet, .smart],
            activeTime: "下午4-6点",
            latitude: 39.92,
            longitude: 116.51
        ),
        Pet(
            name: "豆豆",
            avatar: "豆豆",
            breed: .corgi,
            age: 1,
            tags: [.playful, .curious, .foodie],
            activeTime: "上午9-11点，下午5-7点",
            latitude: 39.93,
            longitude: 116.53
        ),
        Pet(
            name: "Bella",
            avatar: "bella",
            breed: .goldenRetriever,
            age: 4,
            tags: [.friendly, .loyal, .lovesFetch],
            activeTime: "上午7-9点，下午6-8点",
            latitude: 39.91,
            longitude: 116.49
        ),
        Pet(
            name: "Lucky",
            avatar: "lucky",
            breed: .labrador,
            age: 2,
            tags: [.energetic, .goodWithDogs, .lovesWater],
            activeTime: "全天",
            latitude: 39.89,
            longitude: 116.5
        ),
        Pet(
            name: "可乐",
            avatar: "可乐",
            breed: .shibaInu,
            age: 3,
            tags: [.smart, .curious, .trained],
            activeTime: "上午10-12点，下午3-5点",
            latitude: 39.88,
            longitude: 116.495
        )
    ]
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 39.9, longitude: 116.5),
            span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
        )
    )
    
    @State private var selectedPet: Pet?
    
    var body: some View {
        Map(initialPosition: position) {
            ForEach(pets) { pet in
                Annotation(pet.name, coordinate: pet.coordinate) {
                    PetAnnotationView(pet: pet)
                        .onTapGesture {
                            selectedPet = pet
                        }
                }
            }
        }
        .sheet(item: $selectedPet) { pet in
            PetDetailView(pet: pet)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - 地图上的宠物标注视图
struct PetAnnotationView: View {
    let pet: Pet
    
    var body: some View {
        VStack(spacing: 4) {
            Image(pet.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                )
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            
            Text(pet.name)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
    }
}

// MARK: - 宠物详情弹窗
struct PetDetailView: View {
    let pet: Pet
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // 头像和基本信息
                    VStack(spacing: 12) {
                        Image(pet.avatar)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.accentColor, lineWidth: 4)
                            )
                        
                        Text(pet.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 20) {
                            Label(pet.breed.displayName, systemImage: "pawprint.fill")
                            Label(pet.ageDescription, systemImage: "calendar")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                    .padding(.top)
                    
                    Divider()
                    
                    // 标签
                    if !pet.tags.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Label("性格标签", systemImage: "star.fill")
                                .font(.headline)
                                .padding(.horizontal)
                            
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
                                        .background(Color.accentColor.opacity(0.1))
                                        .foregroundStyle(Color.accentColor)
                                        .cornerRadius(16)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    // 活跃时间
                    if !pet.activeTime.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Label("活跃时间", systemImage: "clock.fill")
                                .font(.headline)
                            
                            Text(pet.activeTime)
                                .font(.body)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                    
                    // 互动按钮
                    VStack(spacing: 12) {
                        Button(action: {
                            // TODO: 一键邀玩功能
                        }) {
                            HStack {
                                Image(systemName: "figure.walk")
                                    .font(.title3)
                                Text("一键邀玩")
                                    .font(.headline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                        }
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                // TODO: 添加好友功能
                            }) {
                                HStack {
                                    Image(systemName: "person.badge.plus")
                                    Text("添加好友")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGray6))
                                .foregroundStyle(.primary)
                                .cornerRadius(12)
                            }
                            
                            Button(action: {
                                // TODO: 聊天功能
                            }) {
                                HStack {
                                    Image(systemName: "message.fill")
                                    Text("聊天")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(.systemGray6))
                                .foregroundStyle(.primary)
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("关闭") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    MapView()
}
