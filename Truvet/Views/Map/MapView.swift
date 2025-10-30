//
//  MapView.swift
//  Truvet
//
//  Created by 仲炜 on 2025/10/29.
//

import SwiftUI
import MapKit

struct MapView: View {    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 39.9, longitude: 116.5),
            span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
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
