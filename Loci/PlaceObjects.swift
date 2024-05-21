//
//  PlaceObjects.swift
//  Loci
//
//  Created by Shane Mion on 5/20/24.
//
import SwiftUI
import RealityKit
import RealityKitContent

struct PlaceObjects: View {
    var spaceTitle: String
    var imageName: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
//                .frame(maxWidth: 900, maxHeight: 450)
                .padding()
            Text("Showing \(spaceTitle)")
                .font(.title)
                .padding()
        }
    }
}

#Preview {
    PlaceObjects(spaceTitle: "Among Us Immersive Space", imageName: "amongus_minimap")
}
