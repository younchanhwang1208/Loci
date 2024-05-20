//
//  ImmersiveView.swift
//  Loci
//
//  Created by Youn Hwang on 5/6/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "amongus", in: realityKitContentBundle) {
                
                immersiveContentEntity.position = [25, -5, -50] // Shifted right and forward
                immersiveContentEntity.scale = [1, 1, 1] // Scaled down by a factor of 0.5
                immersiveContentEntity.orientation = simd_quatf(angle: .pi, axis: [0, 1, 0]) // Rotate 180 degrees around the Y axis
                
                content.add(immersiveContentEntity)
                // Add an ImageBasedLight for the immersive content
                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                immersiveContentEntity.components.set(iblComponent)
                immersiveContentEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: immersiveContentEntity))

                // Put skybox here.  See example in World project available at
                // https://developer.apple.com/
            }
            if let plane = try? await Entity(named: "plane" /*in: realityKitContentBundle*/) {
                plane.position = [25, -5, -50] // Shifted right and forward
                content.add(plane)
            }
            if let tea = try? await Entity(named: "tea" /*in: realityKitContentBundle*/) {
                tea.position = [25, -5, -50] // Shifted right and forward
                content.add(tea)
            }
            if let doll = try? await Entity(named: "doll" /*in: realityKitContentBundle*/) {
                doll.position = [25, -5, -50] // Shifted right and forward
                content.add(doll)
            }
            if let banana = try? await Entity(named: "banana" /*in: realityKitContentBundle*/) {
                banana.position = [25, -5, -50] // Shifted right and forward
                content.add(banana)
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
