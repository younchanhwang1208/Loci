//
//  ImmersiveView.swift
//  Loci
//
//  Created by Youn Hwang on 5/6/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    func setPosition(view: UIView, x: CGFloat, y: CGFloat) {
            var frame = view.frame
            frame.origin = CGPoint(x: x, y: y)
            view.frame = frame
        }
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "amongus", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
                immersiveContentEntity.position = [0, 1, 0]
                // Add an ImageBasedLight for the immersive content
                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                immersiveContentEntity.components.set(iblComponent)
                immersiveContentEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: immersiveContentEntity))

                // Put skybox here.  See example in World project available at
                // https://developer.apple.com/
            }
        }
    }
}

#Preview {
    ImmersiveView()
        .previewLayout(.sizeThatFits)
}
