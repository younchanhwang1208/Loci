import SwiftUI
import RealityKit

struct MapNav: View {
    @State private var showImmersiveSpace = false
    @State private var showPanel = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Map Navigation")
                    .font(.largeTitle)
                    .padding(.top, 50)

                Text("Toggle to open the Among Us Immersive Space.")
                    .padding(.bottom, 30)

                Toggle(showImmersiveSpace ? "Close Immersive Space" : "Open Immersive Space", isOn: $showImmersiveSpace)
                    .onChange(of: showImmersiveSpace) { _, isShowing in
                        showPanel = isShowing
                    }
                    .toggleStyle(.button)
                    .padding()
                
                    .navigationDestination(isPresented: $showPanel) {
                        ImmersiveSpacePanel(showImmersiveSpace: $showImmersiveSpace)
                    }
            }
            .padding(70)
        }
    }
}

#Preview {
    MapNav()
}
