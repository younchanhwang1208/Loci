//not using it, you can just ignore

import SwiftUI
import RealityKit
import RealityKitContent
import SceneKit


struct amongusView: View {
    
    var body: some View {
        Model3D(named: "Scene", bundle: realityKitContentBundle) {model in model
            } placeholder: {
            ProgressView()
        }
            .padding(.bottom, 50)
    }
}

#Preview {
    amongusView()
}
