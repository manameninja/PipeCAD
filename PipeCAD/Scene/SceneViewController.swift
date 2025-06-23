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
    var zCameraNodeMultiplier: Float = 2.0
    
    var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = titleString

        let sceneView = SCNView(frame: SceneContainerView.bounds)
        sceneView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sceneView.allowsCameraControl = true
        sceneView.backgroundColor = .systemGray6
        SceneContainerView.addSubview(sceneView)
        SceneContainerView.bringSubviewToFront(titleLabel)

        guard let scene = SCNScene(named: modelName) else { return }

        // Покрасим материалы
        scene.rootNode.enumerateChildNodes { (node, _) in
            guard let geometry = node.geometry else { return }
            for material in geometry.materials {
                material.diffuse.contents = UIColor.lightGray
            }
        }

        // Вычислим общую bounding box всей модели
        var minVec = SCNVector3(Float.greatestFiniteMagnitude,
                                Float.greatestFiniteMagnitude,
                                Float.greatestFiniteMagnitude)
        var maxVec = SCNVector3(-Float.greatestFiniteMagnitude,
                                -Float.greatestFiniteMagnitude,
                                -Float.greatestFiniteMagnitude)

        scene.rootNode.enumerateChildNodes { (node, _) in
            let (localMin, localMax) = node.boundingBox
            let worldMin = node.convertPosition(localMin, to: scene.rootNode)
            let worldMax = node.convertPosition(localMax, to: scene.rootNode)

            minVec.x = Swift.min(minVec.x, worldMin.x)
            minVec.y = Swift.min(minVec.y, worldMin.y)
            minVec.z = Swift.min(minVec.z, worldMin.z)

            maxVec.x = Swift.max(maxVec.x, worldMax.x)
            maxVec.y = Swift.max(maxVec.y, worldMax.y)
            maxVec.z = Swift.max(maxVec.z, worldMax.z)
        }

        let center = SCNVector3(
            (minVec.x + maxVec.x) / 2,
            (minVec.y + maxVec.y) / 2,
            (minVec.z + maxVec.z) / 2
        )

        let size = SCNVector3(
            maxVec.x - minVec.x,
            maxVec.y - minVec.y,
            maxVec.z - minVec.z
        )

        let maxSize = max(size.x, size.y, size.z)

        // Камера
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 10000
        cameraNode.camera?.zNear = 0.001

        let distance = maxSize * 2.5
        cameraNode.position = SCNVector3(center.x, center.y, center.z + distance)
        scene.rootNode.addChildNode(cameraNode)
        sceneView.pointOfView = cameraNode

        sceneView.scene = scene
        sceneView.autoenablesDefaultLighting = true

        // Жест
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        doubleTapRecognizer.delegate = self
        sceneView.addGestureRecognizer(doubleTapRecognizer)
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
