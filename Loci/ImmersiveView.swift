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
                //allow collision for touch (also) -> if it doesn't work just remove
                immersiveContentEntity.generateCollisionShapes(recursive: true)
                
                content.add(immersiveContentEntity)
                // Add an ImageBasedLight for the immersive content
                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                immersiveContentEntity.components.set(iblComponent)
                immersiveContentEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: immersiveContentEntity))
            }
            
            //TO SHANE: 
            //0. Check if the Entity() function is working for plane, tea, doll, and banana (you might have to put them in realitykitcontentbundle jsut like we did for amongus map
            //1. reposition/scale them so that it's visible
            //2. possible film a demo? (or we can work on this together)
            //After our deliverable, I'm adding a feature where if we tap on it (or any gesture), the object disappears
            if let plane = try? await Entity(named: "plane" /*in: realityKitContentBundle*/) {
                plane.position = [25, -5, -50] // Shifted right and forward
                content.add(plane)
                //allow collision for touch-> if it doesn't work just remove
                plane.generateCollisionShapes(recursive: true)
            }
            if let tea = try? await Entity(named: "tea" /*in: realityKitContentBundle*/) {
                tea.position = [25, -5, -50] // Shifted right and forward
                content.add(tea)
                //allow collision for touch-> if it doesn't work just remove
                tea.generateCollisionShapes(recursive: true)
            }
            if let doll = try? await Entity(named: "doll" /*in: realityKitContentBundle*/) {
                doll.position = [25, -5, -50] // Shifted right and forward
                content.add(doll)
                //allow collision for touch-> if it doesn't work just remove
                doll.generateCollisionShapes(recursive: true)
            }
            if let banana = try? await Entity(named: "banana" /*in: realityKitContentBundle*/) {
                banana.position = [25, -5, -50] // Shifted right and forward
                content.add(banana)
                //allow collision for touch-> if it doesn't work just remove
                banana.generateCollisionShapes(recursive: true)
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
