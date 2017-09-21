//
//  ARkitButtonViewController.swift
//  ARKitGlobus
//
//  Created by User1 on 21.09.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARkitButtonViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!

//    var sunSystemPlanets : [Planet] = []
//    var planet  = Planet()
//    
//    
//    var nameOfPlanet = [ "earth","moon","mars" ]
//    var radiusOfPlanet = [0.1 , 0.05 , 0.2]
//    var positionOfPlanet = [SCNVector3(0,0,-0.3), SCNVector3(0,0,-0.5), SCNVector3(0,0,-0.7)]
//    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
//        
//        for i in 0 ..< nameOfPlanet.count{
//            planet.name =  nameOfPlanet[i]
//            planet.radius = CGFloat(radiusOfPlanet[i])
//            planet.position = positionOfPlanet[i]
//            sunSystemPlanets.append(planet)
//        }
//        
//        // Set the view's delegate
//        sceneView.delegate = self
//        
//        // Show statistics such as fps and timing information
//        sceneView.showsStatistics = true
//        
//        // Create a new scene
//        //  let scene = SCNScene(named: "art.scnassets/ship.scn")
//        let scene = SCNScene()
//        
//        
//        for i in 0 ..< sunSystemPlanets.count{
//            let globe = createGlobe(at: sunSystemPlanets[i].position, namePlanet: sunSystemPlanets[i].name , radius: sunSystemPlanets[i].radius )
//            scene.rootNode.addChildNode(globe)
//        }
//        // Set the scene to the view
//        sceneView.scene = scene
    }
    func randomFloat(min: Float, max: Float) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
//    func createGlobe (at position: SCNVector3, namePlanet: String, radius: CGFloat ) ->SCNNode{
//        let sphere = SCNSphere(radius: radius)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named : "art.scnassets/" + namePlanet + ".jpg") //"art.scnassets/earth.jpg"
//        sphere.firstMaterial = material
//        let sphereNode = SCNNode(geometry: sphere)
//        sphereNode.position = position
//        return sphereNode
//    }
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    @IBAction func addButton(_ sender: UIButton) {
        
        let cZ = randomFloat(min: -2, max: -0.2)
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        
        let cc = getCameraCoordinates(sceneView: sceneView)
        cubeNode.position = SCNVector3(cc.x, cc.y, cc.z)
        //cubeNode.position = SCNVector3(0, 0, cZ)
        
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }
   
    @IBAction func dellButton(_ sender: Any) {
        let cupNode = SCNNode()
        
        let cc = getCameraCoordinates(sceneView: sceneView)
        cupNode.position = SCNVector3(cc.x, cc.y, cc.z)
        
        guard let virtualObjectScene = SCNScene(named: "ship.scn", inDirectory: "art.scnassets/torus") else {
            return
        }
        
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            wrapperNode.addChildNode(child)
        }
        cupNode.addChildNode(wrapperNode)
        
        sceneView.scene.rootNode.addChildNode(cupNode)
    }
    struct myCameraCoordinates {
        var x = Float()
        var y = Float()
        var z = Float()
    }
    
    func getCameraCoordinates(sceneView: ARSCNView) -> myCameraCoordinates {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoordinates = MDLTransform(matrix: cameraTransform!)
        
        var cc = myCameraCoordinates()
        cc.x = cameraCoordinates.translation.x
        cc.y = cameraCoordinates.translation.y
        cc.z = cameraCoordinates.translation.z
        
        return cc
    }
    //
//    // MARK: - ARSCNViewDelegate
//    
//    /*
//     // Override to create and configure nodes for anchors added to the view's session.
//     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//     let node = SCNNode()
//     
//     return node
//     }
//     */
//    
//    func session(_ session: ARSession, didFailWithError error: Error) {
//        // Present an error message to the user
//        
//    }
//    
//    func sessionWasInterrupted(_ session: ARSession) {
//        // Inform the user that the session has been interrupted, for example, by presenting an overlay
//        
//    }
//    
//    func sessionInterruptionEnded(_ session: ARSession) {
//        // Reset tracking and/or remove existing anchors if consistent tracking is required
//        
//    }
}

