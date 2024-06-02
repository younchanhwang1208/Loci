import Foundation
import SwiftUI
import RealityKit

struct PlaceColorPairView: View {
    let place: String
    let color: Color

    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
            Text("\(place)")
                .padding(.leading, 10)
        }
    }
}


struct ImmersiveSpacePanel: View {
    @Binding var showImmersiveSpace: Bool
    @Binding var isHandlingImmersiveSpace: Bool
    @State var showObject: Bool = false
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            Text("Immersive Space Panel")
                .font(.largeTitle)
                .padding(.top, 50)

            Button(showImmersiveSpace ? "Close Immersive Space" : "Open Immersive Space") {
                if isHandlingImmersiveSpace { return }
                isHandlingImmersiveSpace = true
                Task {
                    if showImmersiveSpace {
                        await dismissImmersiveSpace()
                        showImmersiveSpace = false
                    } else {
                        switch await openImmersiveSpace(id: "ImmersiveSpace") {
                        case .opened:
                            showImmersiveSpace = true
                        case .error, .userCancelled:
                            showImmersiveSpace = false
                        @unknown default:
                            showImmersiveSpace = false
                        }
                    }
                    isHandlingImmersiveSpace = false
                }
            }
            .buttonStyle(.bordered)
            .padding()
            
            //turn on/off 3d objects
            Button(showObject ? "Hide Objects" : "Show Objects") {
                showObject.toggle()
                Task {
                    await dismissImmersiveSpace()
                    if showObject {
                        await openImmersiveSpace(id: "ImmersiveSpace2")
                    }
                    else {
                        await openImmersiveSpace(id:"ImmersiveSpace")
                    }
                    showImmersiveSpace = true
                    isHandlingImmersiveSpace = true
                    }
                }
                .buttonStyle(.bordered)
                .padding()
            // Place-Color Pairs
            VStack(alignment: .leading) {
                PlaceColorPairView(place: "Medbay", color: .red)
                PlaceColorPairView(place: "Security", color: .orange)
                PlaceColorPairView(place: "Reactor", color: .yellow)
                PlaceColorPairView(place: "Electrical", color: .green)
                PlaceColorPairView(place: "Storage", color: .blue)
                PlaceColorPairView(place: "Communicators", color: .blue.opacity(0.7))
                PlaceColorPairView(place: "Navigation", color: .purple)
                PlaceColorPairView(place: "Oxygen", color: .pink)
                PlaceColorPairView(place: "Cafeteria", color: .green.opacity(0.7))
                PlaceColorPairView(place: "Admin", color: .brown)
            }
            .padding()
        }
    }
}

#Preview {
    ImmersiveSpacePanelPreviewWrapper()
}

// Wrapper to provide the binding for the preview
struct ImmersiveSpacePanelPreviewWrapper: View {
    @State private var showImmersiveSpace = false
    @State private var isHandlingImmersiveSpace = false

    var body: some View {
        ImmersiveSpacePanel(showImmersiveSpace: $showImmersiveSpace, isHandlingImmersiveSpace: $isHandlingImmersiveSpace)
    }
}
