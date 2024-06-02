import SwiftUI
import RealityKit

struct MapNav: View {
    @State private var showImmersiveSpace = false
    @State private var isHandlingImmersiveSpace = false

    var body: some View {
        NavigationStack {
            VStack {
                if !showImmersiveSpace {
                    OriginalPanel(showImmersiveSpace: $showImmersiveSpace, isHandlingImmersiveSpace: $isHandlingImmersiveSpace)
                        .padding(70)
                } else {
                    ImmersiveSpacePanel(showImmersiveSpace: $showImmersiveSpace, isHandlingImmersiveSpace: $isHandlingImmersiveSpace)
                        .padding(70)
                }
            }
            .onDisappear {
                Task {
                    if showImmersiveSpace {
                        await dismissImmersiveSpace()
                        showImmersiveSpace = false
                    }
                }
            }
        }
    }

    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
}

struct OriginalPanel: View {
    @Binding var showImmersiveSpace: Bool
    @Binding var isHandlingImmersiveSpace: Bool
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        ZStack{
            Image("amongus_mapnav")
                .resizable()
                .scaledToFill()
                .scaleEffect(1.5)
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                Text("Map Navigation")
                    .font(.largeTitle)
                    .padding(.top, 50)
                Text("Toggle to open the Among Us Immersive Space.")
                    .padding(.bottom, 30)

                Toggle(showImmersiveSpace ? "Close Immersive Space" : "Open Immersive Space", isOn: $showImmersiveSpace)
                    .onChange(of: showImmersiveSpace) { _, isShowing in
                        if isHandlingImmersiveSpace { return }
                        isHandlingImmersiveSpace = true
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
                            isHandlingImmersiveSpace = false
                        }
                    }
                    .toggleStyle(.button)
                    .padding()
                }
        }
        
        }

            
        
}
