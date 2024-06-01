import Foundation
import RealityKit


class Totem {
    var phrase: String
    var image: String? // Use a string to represent the image name or URL
    var model: RealityKit.Entity? // Use RealityKit Entity for 3D models
    var isAssigned: Bool
    var isTotemVisible: Bool
    var isTotemImage: Bool
    var isTotem3D: Bool
    
    init(phrase: String = "", image: String? = nil, model: RealityKit.Entity? = nil, isAssigned: Bool = false, isTotemVisible: Bool = true, isTotemImage: Bool = false, isTotem3D: Bool = false) {
        self.phrase = phrase
        self.image = image
        self.model = model
        self.isAssigned = isAssigned
        self.isTotemVisible = isTotemVisible
        self.isTotemImage = isTotemImage
        self.isTotem3D = isTotem3D
    }
}
