import SwiftUI

struct MixedVsFull: View {
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
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

#Preview {
    MixedVsFull()
}
