import RealityKit
import SwiftUI

@main
struct CalibrationPortApp: App {
    var body: some Scene {
        WindowGroup {
            RealityView { content in
                let cube = ModelEntity(mesh: .generateBox(size: 0.2),
                                       materials: [SimpleMaterial(color: .orange, isMetallic: false)])
                cube.components.set(SpinComponent())
                content.add(cube)
            }
        }
    }
}

struct SpinComponent: Component {}
