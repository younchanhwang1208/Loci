
import RealityKit
import SwiftUI
import RealityKitContent

@MainActor class ImmersiveViewModel: ObservableObject {
    // create an initialMap variable for relative positions"
    var initialMap: Entity?
    
    // Setting up collision components to every ring, removed the if statement because I think these collision shapes are more consistent, so they override the preset collision components in realitykit"
    func setupTapGesture(for hoop: Entity) {
        // Add a collision component to the hoop if it doesn't already have one
//        if hoop.components[CollisionComponent.self] == nil {
            let collisionComponent = CollisionComponent(shapes: [ShapeResource.generateBox(width: 0.5 / 9, height: 0.2 / 9, depth: 0.5/9)])
            hoop.components.set(collisionComponent)
            hoop.components.set(InputTargetComponent())
//            print("Added collision and input target components to hoop: \(hoop.name)")
        }
//    }
    
    func getTotemLocation(for totem: Entity, index: Int) {
        let totemLocation = totem.position(relativeTo: nil)
        print("Totem \(index) location: \(totemLocation)")
    }
    
    // set up taps on hoops"
    var hoopTapGesture: some Gesture {
        SpatialTapGesture()
            .targetedToAnyEntity()
            .onEnded { [weak self] value in
                guard let self = self, let initialMap = self.initialMap else {
                    print("Self or initialMap is nil, exiting closure")
                    return
                }
                print("Tapped on entity: \(value.entity.name)")
                self.moveEntitiesRelativeToHoop(hoop: value.entity, in: initialMap)
            }
    }
    
    // function responsible for shifting the map over. We move the "Root" child from the "Whatever" usda over, and all of Roots children move with it. Pretty straightforward after overcomplicating it for a real long time lmao
    private func moveEntitiesRelativeToHoop(hoop: Entity, in map: Entity) {
        let hoopPosition = hoop.position(relativeTo: nil)
        let offset = SIMD3<Float>(-hoopPosition.x, 0, -hoopPosition.z)

        print("Moving entities by offset: \(offset)")
        
        
        for child in map.children {
            let currentPosition = child.position(relativeTo: nil)
            print("Before move: entity \(child.name) is at position: \(currentPosition)")

            let newPosition = currentPosition + offset
//            child.setPosition(newPosition, relativeTo: nil) // sharp teleportations
            let transform = Transform(
                scale: SIMD3<Float>(10, 10, 10),
                translation: newPosition
            )
            child.move(to: transform, relativeTo: nil, duration: 1.0)

            print("Moved entity \(child.name) to new position: \(newPosition)")
        }
    }
}
