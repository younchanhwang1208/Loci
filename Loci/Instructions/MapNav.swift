import SwiftUI
import RealityKit

struct MapNav: View {
    @State private var showImmersiveSpace = false

    var body: some View {
        NavigationStack {
            VStack {
                if !showImmersiveSpace {
                    OriginalPanel(showImmersiveSpace: $showImmersiveSpace)
                        .padding(70)
                } else {
                    ImmersiveSpacePanel(showImmersiveSpace: $showImmersiveSpace)
                        .padding(70)
                }
            }
        }
    }
}

struct OriginalPanel: View {
    @Binding var showImmersiveSpace: Bool
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            Text("Map Navigation")
                .font(.largeTitle)
                .padding(.top, 50)

            Text("Toggle to open the Among Us Immersive Space.")
                .padding(.bottom, 30)

            Toggle(showImmersiveSpace ? "Close Immersive Space" : "Open Immersive Space", isOn: $showImmersiveSpace)
                .onChange(of: showImmersiveSpace) { _, isShowing in
                    Task {
                        if isShowing {
                            switch await openImmersiveSpace(id: "ImmersiveSpace") {
                            case .opened:
                                break
                            case .error, .userCancelled:
                                showImmersiveSpace = false
                            @unknown default:
                                showImmersiveSpace = false
                            }
                        } else {
                            await dismissImmersiveSpace()
                        }
                    }
                }
                .toggleStyle(.button)
                .padding()
        }
    }
}
