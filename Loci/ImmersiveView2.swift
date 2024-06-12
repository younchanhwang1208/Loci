import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView2: View {
    @StateObject private var model = ImmersiveViewModel()
    
    var body: some View {
        RealityView { content in
            // Load the initial RealityKit content from the USDA file
            if let map = try? await Entity(named: "Whatever_on", in: realityKitContentBundle) {
                // Adjusted position, scale, and orientation
                map.position = [-2, 0, 9]
                map.scale = [10, 10, 10]
                content.add(map)

                // Add an ImageBasedLight for the immersive content
                if let resource = try? await EnvironmentResource(named: "ImageBasedLight") {
                    let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                    map.components.set(iblComponent)
                    map.components.set(ImageBasedLightReceiverComponent(imageBasedLight: map))
                }
                
                // Apply holographic material to all nested entities within "Root"
                if let rootEntity = map.findEntity(named: "Root") {
                    applyHolographicMaterial(to: rootEntity)
                }
                
                // Add tap gestures to hoops
                for i in 0...75 {
                    let hoopName = "hooptest_\(i)"
     
                    // Set up tap gesture for default hoops
                    if let hoop = map.findEntity(named: hoopName) {
                        model.setupTapGesture(for: hoop)
                        print("Set up tap gesture for hoop: \(hoopName)")
                    } else {
                        print("Could not find hoop: \(hoopName)")
                    }
                }
                
                // Hide the hoops, store their locations
                for i in 0...50 {
                    let locName = "loc_\(i)"
                    if let totem = map.findEntity(named: locName) {
                        model.setupTapGesture(for: totem) // enable clickable
                        model.getTotemLocation(for: totem, index: i)
                        totem.isEnabled = true
                        print("enabled hoop: \(locName)")
                    } else {
                        print("Could not find hoop: \(locName)")
                    }
                }
                
                // Store the initial map entity in the model ("Whatever" in reality kit)
                model.initialMap = map
            } else {
                print("Could not load initial RealityKit content")
            }
        }
        .gesture(model.hoopTapGesture)
    }
    
    // Function to apply holographic material to all nested entities
    private func applyHolographicMaterial(to entity: Entity) {
        for child in entity.children {
            // Skip entities with names starting with "hooptest_", "loc_", or containing "amongus"
            if child.name.hasPrefix("hooptest_") || child.name.hasPrefix("loc_") || child.name.contains("amongus") {
                continue
            }

            if var model = child.components[ModelComponent.self] {
                let holographicColor = UIColor(red: 0.0, green: 1.0, blue: 1.0, alpha: 0.8) // Light blue with some transparency
                let holographicMaterial = UnlitMaterial(color: holographicColor)
                model.materials = [holographicMaterial]
                child.components[ModelComponent.self] = model
                print("Applied holographic material to entity: \(child.name)")
            }
            // Recursively apply holographic material to all children
            applyHolographicMaterial(to: child)
        }
    }
}

#Preview {
    ImmersiveView2()
        .previewLayout(.sizeThatFits)
}
