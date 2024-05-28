import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    /* 
     Following the "MVVM (Model-View-Model View)" Swift decoupling strategy.
     
     The struct ImmersiveView is the frontend stuff, where we load content into our RealityView. We first load map in, which is the "Whatever" entity in the RealityKitContent folder. The "Whatever" entity holds a child called "Root", and "Root" contains its own children, namely the "hoops_{i}" and the "amongus" usda's (The amongus usda is the map, so the naming scheme is kind of confusing but hopefully this comment cleared it up"
     
     The image based light is default, we might need to add it to Step View 2 to the hoop, because the hoop in the preview is not lit"
     
     The for loop looping through hoops is adding the collision components to each of the hoops, which basically just ensures that they are able to be pinched/tapped/selected by the user when clicked on after SpatialTapGesture is placed on the entire "Whatever" entity in line #49. The collision component code is executed by finding each of the hoops prerendered into the map, and calling the method defined in the VM component in "ImmersiveViewModel"
     
     
    */
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
