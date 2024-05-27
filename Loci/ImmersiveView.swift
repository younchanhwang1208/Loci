import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    var body: some View {
        RealityView { content in
            // Load the initial RealityKit content from the USDA file
            if let map = try? await Entity(named: "Whatever", in: realityKitContentBundle) {
                // Adjusted position, scale, and orientation
                map.position = [0, 0, 0]
                map.scale = [1, 1, 1]
                map.orientation = simd_quatf(angle: .pi, axis: [0, 1, 0]) // Rotate 180 degrees

                content.add(map)

                // Add an ImageBasedLight for the immersive content
                if let resource = try? await EnvironmentResource(named: "ImageBasedLight") {
                    let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                    map.components.set(iblComponent)
                    map.components.set(ImageBasedLightReceiverComponent(imageBasedLight: map))
                }                
            }
        }
    }

    // Function to handle hoop tap
    private func handleHoopTap(id: String) {
        print("Hoop with ID \(id) tapped")
        // Add your custom action based on the hoop's unique ID here
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
