import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)

                Text("Welcome to Loci: Memory Palace!").font(.largeTitle)

                NavigationLink(destination: MixedVsFull()) {
                    Text("Choose Mode")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
