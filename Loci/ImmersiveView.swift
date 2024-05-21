import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let anchorEntity = try? await AnchorEntity(named: "amongus", in: realityKitContentBundle) {
                
                anchorEntity.position = [3, 1, -6] // Adjusted position
                anchorEntity.scale = [0.1, 0.1, 0.1] // Scaled down
                anchorEntity.orientation = simd_quatf(angle: .pi, axis: [0, 1, 0]) // Rotate 180 degrees
                
                // Allow collision for touch and physics
//                anchorEntity.generateCollisionShapes(recursive: true)
//                let physicsBodyComponent = PhysicsBodyComponent(massProperties: .default, material: .default, mode: .static)
//                let collisionComponent = CollisionComponent(shapes: [ShapeResource.generateBox(size: anchorEntity.scale)])
//                
//                anchorEntity.components.set(physicsBodyComponent)
//                anchorEntity.components.set(collisionComponent)
//                
                content.add(anchorEntity)

                // Add an ImageBasedLight for the immersive content
                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                anchorEntity.components.set(iblComponent)
                anchorEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: anchorEntity))

                // Add other entities to the amongus map
                await addEntity(named: "plane", to: anchorEntity, at: [60, 3, 20], scale: [0.03, 0.03, 0.03])
                await addEntity(named: "tea", to: anchorEntity, at: [20, 1, 30], scale: [0.2, 0.2, 0.2])
                await addEntity(named: "doll", to: anchorEntity, at: [20, 3, 0], scale: [0.2, 0.2, 0.2])
                await addEntity(named: "banana", to: anchorEntity, at: [20, 0, -30], scale: [0.5, 0.5, 0.5])
            }
        }
    }

    // Helper function to add entities with collision and physics
    @MainActor
    private func addEntity(named name: String, to parent: Entity, at position: SIMD3<Float>, scale: SIMD3<Float>) async {
        if let entity = try? await Entity(named: name, in: realityKitContentBundle) {
            entity.position = position
            entity.scale = scale
//            entity.generateCollisionShapes(recursive: true)
//            
//            let physicsBodyComponent = PhysicsBodyComponent(massProperties: .default, material: .default, mode: .static)
//            let collisionComponent = CollisionComponent(shapes: [ShapeResource.generateBox(size: scale)])
//            
//            entity.components.set(physicsBodyComponent)
//            entity.components.set(collisionComponent)
//            
            parent.addChild(entity)
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
