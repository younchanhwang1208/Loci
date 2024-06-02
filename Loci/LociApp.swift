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
        ImmersiveSpace(id: "ImmersiveSpace2") {
            ImmersiveView2()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}

