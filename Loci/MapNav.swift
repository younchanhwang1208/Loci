// MapNav.swift
import SwiftUI
import RealityKit

struct MapNav: View {
    @State private var showImmersiveSpace1 = false
    @State private var showImmersiveSpace2 = false
    @State private var showImmersiveSpace3 = false
    @State private var immersiveSpace1IsShown = false
    @State private var immersiveSpace2IsShown = false
    @State private var immersiveSpace3IsShown = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        VStack {
            Toggle("Open Immersive Space 1", isOn: $showImmersiveSpace1)
                .toggleStyle(.button)
                .padding(.top, 20)
            
            Toggle("Open Immersive Space 2", isOn: $showImmersiveSpace2)
                .toggleStyle(.button)
                .padding(.top, 20)
            
            Toggle("Open Immersive Space 3", isOn: $showImmersiveSpace3)
                .toggleStyle(.button)
                .padding(.top, 20)
        }
        .onChange(of: showImmersiveSpace1) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace1") {
                    case .opened:
                        immersiveSpace1IsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpace1IsShown = false
                        showImmersiveSpace1 = false
                    }
                } else if immersiveSpace1IsShown {
                    await dismissImmersiveSpace()
                    immersiveSpace1IsShown = false
                }
            }
        }
        .onChange(of: showImmersiveSpace2) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace2") {
                    case .opened:
                        immersiveSpace2IsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpace2IsShown = false
                        showImmersiveSpace2 = false
                    }
                } else if immersiveSpace2IsShown {
                    await dismissImmersiveSpace()
                    immersiveSpace2IsShown = false
                }
            }
        }
        .onChange(of: showImmersiveSpace3) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace3") {
                    case .opened:
                        immersiveSpace3IsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpace3IsShown = false
                        showImmersiveSpace3 = false
                    }
                } else if immersiveSpace3IsShown {
                    await dismissImmersiveSpace()
                    immersiveSpace3IsShown = false
                }
            }
        }
    }
}

#Preview {
    MapNav()
}
