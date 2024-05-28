import SwiftUI
import RealityKit
import RealityKitContent

/*
 This is a model I 'borrowed' from YT which basically allows the hoop in Step2View to be clicked on / dragged / played with. It's referenced in Step2View.
 */
struct HoopModel: View {
    var orientation: SIMD3<Double> = .zero
    var scale: CGFloat = 0.3
    
    var body: some View {
        Model3D(named: "hooptest", bundle: realityKitContentBundle) { model in
            model.resizable()
                .scaledToFit()
                .scaleEffect(scale)
                .rotation3DEffect(
                    Rotation3D(
                        eulerAngles: .init(angles: orientation, order: .xyz)
                    )
                )
        } placeholder: {
            ProgressView()
                .offset(z: 150)
        }
    }
}

#Preview {
    HoopModel()
}
