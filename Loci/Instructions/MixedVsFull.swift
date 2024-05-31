import SwiftUI

struct MixedVsFull: View {
    @State private var isHovering = false
    var body: some View {
        VStack {
            Button("Mixed Reality") {
                // Future implementation
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray)
            .foregroundColor(.white)
            .font(.title)
            .cornerRadius(10)
            .padding()

            NavigationLink(destination: PlaceObjects(spaceTitle: "Among Us Immersive Space", imageName: "amongus_minimap")) {
                Text("Full Immersion")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        Image("amongus_button")
                            .resizable()
                            .scaledToFill()
                            .opacity(0.5)
                            .onHover { hovering in
                                print("hovering on")
                                isHovering = hovering
                            }
                            .scaleEffect(isHovering ? 1.7 : 1.0)
                            .overlay(Color.black.opacity(0.3))
                            .cornerRadius(10)
                            //.animation(.easeInOut(duration: 0.3), value: isHovering)
                    )
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .hoverEffect(.lift)
                    .padding()

            }
        }
    }
}

#Preview {
    MixedVsFull()
}
