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
                
                var wingIndex = 0
                // Add tap gestures to hoops
                for i in 0...75 {
                    let hoopName = "hooptest_\(i)"

                    // sector_0 (Medbay)
                    if i == 10 {
//                        if let wing = map.findEntity(named: "wings_\(wingIndex)") {
                        if let wing = map.findEntity(named: "wingstest") {
                            model.setupAutoCollider(for: wing)
                            print("Set up auto collider for Medbay: wings_\(wingIndex)")
                            wingIndex += 1
                        } else {
                            print("Could not find Medbay wing: wings_\(wingIndex)")
                        }
                    }

                    // sector_1 (Security)
                    if i == 22 {
                        if let wing = map.findEntity(named: "wings_\(wingIndex)") {
                            model.setupAutoCollider(for: wing)
                            print("Set up auto collider for Security: wings_\(wingIndex)")
                            wingIndex += 1
                        } else {
                            print("Could not find Security wing: wings_\(wingIndex)")
                        }
                    }

                    // sector_2 (Reactor)
                    if i == 23 {
                        if let wing = map.findEntity(named: "wings_\(wingIndex)") {
                            model.setupAutoCollider(for: wing)
                            print("Set up auto collider for Reactor: wings_\(wingIndex)")
                            wingIndex += 1
                        } else {
                            print("Could not find Reactor wing: wings_\(wingIndex)")
                        }
                    }

                    // sector_3 (Electrical)
                    if i == 31 {
                        if let wing = map.findEntity(named: "wings_\(wingIndex)") {
                            model.setupAutoCollider(for: wing)
                            print("Set up auto collider for Electrical: wings_\(wingIndex)")
                            wingIndex += 1
                        } else {
                            print("Could not find Electrical wing: wings_\(wingIndex)")
                        }
                    }

                    // sector_4 (Storage)
                    if i == 33 {
                        if let wing = map.findEntity(named: "wings_\(wingIndex)") {
                            model.setupAutoCollider(for: wing)
                            print("Set up auto collider for Storage: wings_\(wingIndex)")
                            wingIndex += 1
                        } else {
                            print("Could not find Storage wing: wings_\(wingIndex)")
                        }
                    }

                    // sector_5 (Communicators)
                    if i == 45 {
                        if let wing = map.findEntity(named: "wings_\(wingIndex)") {
                            model.setupAutoCollider(for: wing)
                            print("Set up auto collider for Communicators: wings_\(wingIndex)")
                            wingIndex += 1
                        } else {
                            print("Could not find Communicators wing: wings_\(wingIndex)")
                        }
                    }

                    // sector_6 (Navigation)
                    if i == 54 {
                        if let wing = map.findEntity(named: "wings_\(wingIndex)") {
                            model.setupAutoCollider(for: wing)
                            print("Set up auto collider for Navigation: wings_\(wingIndex)")
                            wingIndex += 1
                        } else {
                            print("Could not find Navigation wing: wings_\(wingIndex)")
                        }
                    }

                    // sector_7 (Oxygen)
                    if i == 57 {
                        if let wing = map.findEntity(named: "wings_\(wingIndex)") {
                            model.setupAutoCollider(for: wing)
                            print("Set up auto collider for Oxygen: wings_\(wingIndex)")
                            wingIndex += 1
                        } else {
                            print("Could not find Oxygen wing: wings_\(wingIndex)")
                        }
                    }

                    // sector_8 (Cafeteria)
                    if i == 1 {
                        if let wing = map.findEntity(named: "wings_\(wingIndex)") {
                            model.setupAutoCollider(for: wing)
                            print("Set up auto collider for Cafeteria: wings_\(wingIndex)")
                            wingIndex += 1
                        } else {
                            print("Could not find Cafeteria wing: wings_\(wingIndex)")
                        }
                    }

                    // sector_9 (Admin)
                    if i == 19 {
                        if let wing = map.findEntity(named: "wings_\(wingIndex)") {
                            model.setupAutoCollider(for: wing)
                            print("Set up auto collider for Admin: wings_\(wingIndex)")
                            wingIndex += 1
                        } else {
                            print("Could not find Admin wing: wings_\(wingIndex)")
                        }
                    }

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
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
