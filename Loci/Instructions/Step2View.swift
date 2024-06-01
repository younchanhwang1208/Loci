import SwiftUI
import RealityKit
import RealityKitContent

struct Step2View: View {
    var body: some View {
        GeometryReader { proxy in
            let textWidth = min(max(proxy.size.width * 0.4, 300), 500)
            ZStack {
                HStack(spacing: 60) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Navigating the Memory Palace")
                            .font(.largeTitle)
                            .padding(.bottom, 15)

                        Text("""
                        - Navigate the memory palace by pinching the Waypoint Hoops placed around the map or by using your Navigation Panel to visit specific rooms.
                        - Selecting a hoop will teleport you to the hoops new location.
                        - Move your head to look around the memory palace, or pinch and drag the map to change your view.
                        """)
                        .padding(.bottom, 30)

                        NavigationLink(destination: Step3View()) {
                            Text("Next")
                                .padding()
                                .cornerRadius(10)
                        }
                    }
                    .frame(width: textWidth, alignment: .leading)

                    Color.clear
                        .overlay {
                            // See HoopModel component comments
                            HoopModel(orientation: [-0.3,0.4,0])
                                .dragRotation(yawLimit: .degrees(45), pitchLimit: .degrees(45))
                                .frame(height: 100)
                                .frame(depth: 100)
                                .offset(z: 250)
                        }
                }
                .offset(y: -30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(70)
    }
}

#Preview {
    Step2View()
}
