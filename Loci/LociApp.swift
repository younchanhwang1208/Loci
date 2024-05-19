//
//  LociApp.swift
//  Loci
//
//  Created by Youn Hwang on 5/6/24.
//

import SwiftUI

@main
struct LociApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
        
        ImmersiveSpace(id: "ImmersiveSpace1") {
            ImmersiveView1()
        }.immersionStyle(selection: .constant(.full), in: .full)
        
//        ImmersiveSpace2(id: "ImmersiveSpace2") {
//            ImmersiveView()
//        }.immersionStyle(selection: .constant(.full), in: .full)
//        
//        ImmersiveSpace3(id: "ImmersiveSpace3") {
//            ImmersiveView()
//        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
