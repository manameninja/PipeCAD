//
//  ViewController.swift
//  SceneApp
//
//  Created by Даниил Павленко on 04.06.2025.
//

import UIKit
import SceneKit

class SceneViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var SceneContainerView: UIView!
    var titleString = "3D"
    var modelName = "ball_soccerball_realistic.usdz"
    
    var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleString
        
        let sceneView = SCNView(frame: SceneContainerView.bounds)
        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = .white
        SceneContainerView.addSubview(sceneView)
        SceneContainerView.bringSubviewToFront(titleLabel)
        
        guard let scene = SCNScene(named: modelName) else { return }
        print(modelName)
        sceneView.scene = scene
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
//        if let modelNode = scene.rootNode.childNodes.first {
//            let (minVec, maxVec) = modelNode.boundingBox
//            let maxDim = Swift.max(
//                maxVec.x - minVec.x,
//                maxVec.y - minVec.y,
//                maxVec.z - minVec.z
//            )
//            
//            cameraNode.position = SCNVector3(0, 0, maxDim * 2)
//            modelNode.position = SCNVector3(-0, -0, -150)
//        }
        
        sceneView.autoenablesDefaultLighting = true
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        sceneView.addGestureRecognizer(doubleTapRecognizer)

        doubleTapRecognizer.delegate = self
    }
    
    @objc func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        // подавляю дабл тап
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension SceneViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
