
import RealityKit
import SwiftUI
import RealityKitContent

@MainActor class ImmersiveViewModel: ObservableObject {
    var camEntity: AnchorEntity = {
        let camPov = AnchorEntity()
        camPov.position = [0, 0, 0]
        return camPov
    }()
    
    func setupTapGesture(for hoop: Entity) {
        // Add a collision component to the hoop if it doesn't already have one
        if hoop.components[CollisionComponent.self] == nil {
            let collisionComponent = CollisionComponent(shapes: [ShapeResource.generateBox(width: 2.0, height: 2.0, depth: 0.02)])
            hoop.components.set(collisionComponent)
            hoop.components.set(InputTargetComponent())
            print("Added collision and input target components to hoop: \(hoop.name)")
        }
        }
    
    var hoopTapGesture: some Gesture {
        SpatialTapGesture().targetedToAnyEntity().onEnded { [weak self] value in
            guard let self = self else {
                print("Self is nil, exiting closure")
                return
            }
            print("Tapped on entity: \(value.entity.name)")
            self.moveToHoop(hoop: value.entity)
        }
    }
    
    private func moveToHoop(hoop: Entity) {
        let hoopPosition = hoop.position(relativeTo: nil)
        print("Moving camera to hoop position: \(hoopPosition)")
        camEntity.setPosition(hoopPosition, relativeTo: nil)
    }
}
