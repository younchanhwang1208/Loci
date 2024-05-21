// ContentView.swift
import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        NavigationStack {
            VStack {
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)

                Text("Welcome to Loci: Memory Palace!").font(.largeTitle)
                
                NavigationLink(destination: MapNav()) {
                    Text("Maps")
                        .font(.title)
                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
