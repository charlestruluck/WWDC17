
// SceneKit stuff for the ProgrammingView background. Built to make my code cleaner. :)

import UIKit
import SceneKit

class Scene: SCNScene {
    
    let view: SCNView
    let camera: SCNCamera
    let cameraNode: SCNNode
    let sphere: SCNSphere
    let sphereNode: SCNNode
    
    init(frame: CGRect) {
        self.view = SCNView(frame: frame)
        self.camera = SCNCamera()
        self.cameraNode = SCNNode()
        self.sphere = SCNSphere(radius: 1.0)
        self.sphereNode = SCNNode(geometry: sphere)
        self.sphereNode.rotation = SCNVector4(x: 1.0, y: 1.0, z: 0.0, w: 0.0)
        
        super.init()
        
        self.view.scene = self
        self.view.debugOptions = [.showWireframe]
        self.view.backgroundColor = Color.civic
        self.sphere.firstMaterial?.diffuse.contents = UIColor.clear.cgColor
        self.sphere.firstMaterial?.specular.contents = UIColor.clear.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // This function is specifically to avoid importing SceneKit into ProgrammingView.swift.
    func setCameraPosition(x: Float, y: Float, z: Float) {
        cameraNode.position = SCNVector3(x: x, y: y, z: z)
    }
    
    // Easily add both objects to the scene.
    func setRootNodes() {
        self.rootNode.addChildNode(cameraNode)
        self.rootNode.addChildNode(sphereNode)
    }
    
    // Spin the sphere!
    func spin() -> CABasicAnimation {
        let spin = CABasicAnimation(keyPath: "rotation.w")
        spin.toValue = 2.0 * .pi
        spin.duration = 7
        spin.repeatCount = HUGE
        return spin
    }
    
}
