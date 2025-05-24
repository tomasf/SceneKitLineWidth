import Cocoa
import SceneKit

@main class AppDelegate: NSObject, NSApplicationDelegate {}

class ViewController: NSViewController, SCNSceneRendererDelegate {
    @IBOutlet var sceneView: SCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.delegate = self
        sceneView.debugOptions = [.renderAsWireframe]

        let torus = SCNTorus(ringRadius: 5, pipeRadius: 2)
        torus.firstMaterial?.diffuse.contents = NSColor.red
        torus.firstMaterial?.isDoubleSided = true
        let torusNode = SCNNode(geometry: torus)
        sceneView.scene?.rootNode.addChildNode(torusNode)

        torusNode.runAction(.repeatForever(.rotate(
            by: .pi * 2,
            around: SCNVector3(1, 1, 0),
            duration: 5
        )))
    }

    func renderer(_ renderer: any SCNSceneRenderer, willRenderScene: SCNScene, atTime: TimeInterval) {
        if let encoder = renderer.currentRenderCommandEncoder as? NSObject,
           encoder.responds(to: NSSelectorFromString("setLineWidth:"))
        {
            encoder.setValue(6.0, forKey: "lineWidth")
        }
    }
}
