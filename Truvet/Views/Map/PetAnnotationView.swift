//
//  PetAnnotationView.swift
//  Truvet
//
//  Created by Wei on 2025/10/30.
//

import SwiftUI

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
                        .stroke(.regularMaterial, lineWidth: 2)
                )
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            
            Text(pet.name)
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.regularMaterial)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
    }
}

#Preview {
    PetAnnotationView(pet: Pet.samplePets[0])
}
