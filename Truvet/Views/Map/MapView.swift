//
//  MapView.swift
//  Truvet
//
//  Created by 仲炜 on 2025/10/29.
//

import SwiftUI
import MapKit

struct MapView: View {    
    // 初始位置：上海市中心，跨度覆盖 6 只宠物所在的市中心区域
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 31.2304, longitude: 121.4737),
            span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.12)
        )
    )
    
    @State private var selectedPet: Pet?
    
    var body: some View {
        Map(initialPosition: position) {
            ForEach(Pet.samplePets) { pet in
                Annotation("", coordinate: pet.coordinate) {
                    Button {
                        selectedPet = pet
                    } label: {
                        PetAnnotationView(pet: pet)
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

#Preview {
    MapView()
}
