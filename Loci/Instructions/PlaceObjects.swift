import SwiftUI
import RealityKit
import RealityKitContent

struct PlaceObjects: View {
    var spaceTitle: String
    var imageName: String

    var body: some View {
        GeometryReader { proxy in
            let textWidth = min(max(proxy.size.width * 0.4, 300), 500)
            ZStack {
                HStack(spacing: 60) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Memory Palace Instructions")
                            .font(.system(size: 50, weight: .bold))
                            .padding(.bottom, 15)

                        Text("""
                        - Follow the steps to understand and utilize the memory palace technique.
                        """)
                        .padding(.bottom, 30)
                        .accessibilitySortPriority(3)

                        NavigationLink(destination: Step1View()) {
                            Text("Next")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .frame(width: textWidth, alignment: .leading)
                }
                .offset(y: -30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(70)
    }
}

#Preview {
    PlaceObjects(spaceTitle: "Among Us Immersive Space", imageName: "amongus_minimap")
}
