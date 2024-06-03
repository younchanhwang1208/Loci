import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView2: View {
    @StateObject private var model = ImmersiveViewModel()
    
    var body: some View {
        RealityView { content in
            // Load the initial RealityKit content from the USDA file
            if let map = try? await Entity(named: "Whatever_On", in: realityKitContentBundle) {
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
                        print("Disabled hoop: \(locName)")
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
}

#Preview {
    ImmersiveView2()
        .previewLayout(.sizeThatFits)
}
