//
//  EnvironmentKeys.swift
//  Loci
//
//  Created by Shane Mion on 6/1/24.
//

import Foundation

import SwiftUI
import RealityKit

struct DismissImmersiveSpaceKey: EnvironmentKey {
    static let defaultValue: (() -> Void) = { }
}

extension EnvironmentValues {
    var dismissImmersiveSpaceAction: () -> Void {
        get { self[DismissImmersiveSpaceKey.self] }
        set { self[DismissImmersiveSpaceKey.self] = newValue }
    }
}
