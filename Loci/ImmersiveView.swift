import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @StateObject private var model = ImmersiveViewModel()
    
    var body: some View {
        RealityView { content in
            // Load the initial RealityKit content from the USDA file
            if let map = try? await Entity(named: "Whatever", in: realityKitContentBundle) {
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
                for i in 0...16 {
                    let hoopName = "hooptest_\(i)"
                    if let hoop = map.findEntity(named: hoopName) {
//                        print("Setting up tap gesture for hoop: \(hoopName)")
                        model.setupTapGesture(for: hoop)
                        print("Set up tap gesture for hoop: \(hoopName)")
                    } else {
                        print("Could not find hoop: \(hoopName)")
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
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
