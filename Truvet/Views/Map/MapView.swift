//
//  MapView.swift
//  Truvet
//
//  Created by signerlabs.
//

import SwiftUI
import MapKit

struct MapView: View {
    // Initial position: downtown Shanghai, span covers the area where all 6 pets are located
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
