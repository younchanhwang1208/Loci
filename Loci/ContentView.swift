import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                RealityView { content in
                    do {
                        if let entity = try? await Entity(named: "Whatever", in: realityKitContentBundle) {
                            entity.scale = [0.06, 0.06, 0.06]  // Scaling down by a factor of 100
                            let tiltAngle = simd_quatf(angle: .pi / 4, axis: [0.8, 0, 0]) // 45 degrees
                            entity.orientation = tiltAngle
                            content.add(entity)
                            
                            if let resource = try? await EnvironmentResource(named: "ImageBasedLight") {
                                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                                entity.components.set(iblComponent)
                                entity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: entity))
                            }
                        }
                        
                    }
                }
                .padding(.bottom, 20)

                Text("Welcome to Loci: Memory Palace!").font(.largeTitle)

                NavigationLink(destination: MixedVsFull()) {
                    Text("Choose Mode")
                        .font(.title)
                        .padding()
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }.padding(.bottom, 50)
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
