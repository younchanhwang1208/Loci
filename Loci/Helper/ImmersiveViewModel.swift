import RealityKit
import SwiftUI
import RealityKitContent

@MainActor class ImmersiveViewModel: ObservableObject {
    var initialMap: Entity?
    var totemDictionary: [String: [Int: Totem]] = [:]

    init() {
        for i in 0..<10 {
            let key = "sector_\(i)"
            var sectorTotems: [Int: Totem] = [:]
            for j in 0..<5 {
                let totemIndex = j
                sectorTotems[totemIndex] = Totem()
            }
            totemDictionary[key] = sectorTotems
        }
    }
    
    func setupTapGesture(for entity: Entity) {
        let collisionComponent = CollisionComponent(shapes: [ShapeResource.generateBox(width: 0.5 / 9, height: 0.2 / 9, depth: 0.5 / 9)])
        entity.components.set(collisionComponent)
        entity.components.set(InputTargetComponent())
    }

    func setupAutoCollider(for entity: Entity) {
        if let modelEntity = entity as? ModelEntity {
            let boundingBox = modelEntity.visualBounds(relativeTo: entity).extents
            let collisionComponent = CollisionComponent(shapes: [ShapeResource.generateBox(size: boundingBox)])
            entity.components.set(collisionComponent)
            entity.components.set(InputTargetComponent())
            print("Set up as;dlfiha;oeghpoqerghpoqegr")
        }
    }
    
    func getTotemLocation(for totem: Entity, index: Int) {
        let totemLocation = totem.position(relativeTo: nil)
        print("Totem \(index) location: \(totemLocation)")

        let totemInstance = Totem(phrase: "Sample Phrase")
        let sectorIndex = index / 5
        let totemIndex = index % 5
        let key = "sector_\(sectorIndex)"

        totemDictionary[key]?[totemIndex] = totemInstance
    }

    var hoopTapGesture: some Gesture {
        SpatialTapGesture()
            .targetedToAnyEntity()
            .onEnded { [weak self] value in
                guard let self = self, let initialMap = self.initialMap else {
                    print("Self or initialMap is nil, exiting closure")
                    return
                }
                print("Tapped on entity: \(value.entity.name)")
                self.moveEntitiesRelativeToHoop(entity: value.entity, in: initialMap)
            }
    }
    
    private func moveEntitiesRelativeToHoop(entity: Entity, in map: Entity) {
        let hoopPosition = entity.position(relativeTo: nil)
        let offset = SIMD3<Float>(-hoopPosition.x, 0, -hoopPosition.z)

        print("Moving entities by offset: \(offset)")
        
        for child in map.children {
            let currentPosition = child.position(relativeTo: nil)
            print("Before move: entity \(child.name) is at position: \(currentPosition)")

            let newPosition = currentPosition + offset
            let transform = Transform(
                scale: SIMD3<Float>(10, 10, 10),
                translation: newPosition
            )
            child.move(to: transform, relativeTo: nil, duration: 1.0)

            print("Moved entity \(child.name) to new position: \(newPosition)")
        }
    }
}
