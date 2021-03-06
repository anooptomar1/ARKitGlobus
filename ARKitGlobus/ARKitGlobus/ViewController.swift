//
//  ViewController.swift
//  ARKitGlobus
//
//  Created by User1 on 21.09.17.
//  Copyright © 2017 User1. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    var sunSystemPlanets : [Planet] = []
    var planet  = Planet()
    // Create a new scene
    let scene = SCNScene()
    
    var nameOfPlanet = [ "earth","moon","mars" ]
    var radiusOfPlanet = [0.1 , 0.05 , 0.2]
    var positionOfPlanet = [SCNVector3(0,0,-0.3), SCNVector3(0,0,-0.5), SCNVector3(0,0,-0.7)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
 
        for i in 0 ..< nameOfPlanet.count{
        planet.name =  nameOfPlanet[i]
        planet.radius = CGFloat(radiusOfPlanet[i])
        planet.position = positionOfPlanet[i]
        sunSystemPlanets.append(planet)
        }
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //  let scene = SCNScene(named: "art.scnassets/ship.scn")
       // let scene = SCNScene()
       
        
     
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    func createGlobe (at position: SCNVector3, namePlanet: String, radius: CGFloat ) ->SCNNode{
        let sphere = SCNSphere(radius: radius)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named : "art.scnassets/" + namePlanet + ".jpg") //"art.scnassets/earth.jpg"
        sphere.firstMaterial = material
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = position
        
        
        return sphereNode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{return}
        let result = sceneView.hitTest(touch.location(in: sceneView), types: [ARHitTestResult.ResultType.featurePoint])
        guard let hitResult = result.last else {return}
        
        // let hitTransform = SCNMatrix4FromGLKMatrix4(hitResult.worldTransform)
        
        let hitTransform = SCNMatrix4(hitResult.worldTransform)
        
        for i in 0 ..< sunSystemPlanets.count{
            let hitVector  = SCNVector3Make(hitTransform.m41 + sunSystemPlanets[i].position.x , hitTransform.m42 + sunSystemPlanets[i].position.y, hitTransform.m43 + sunSystemPlanets[i].position.z)
            
            let globe = createGlobe(at: hitVector , namePlanet: sunSystemPlanets[i].name , radius: sunSystemPlanets[i].radius )
           sceneView.scene.rootNode.addChildNode(globe)
            
        }
    }
    
//    func createBall(position: SCNVector3){
//        var ballShape = SCNSphere(radius: 0.1)
//        var ballNode = SCNNode(geometry: ballShape)
//        ballNode.position = position
//        sceneView.scene.rootNode.addChildNode(ballNode)
//
//    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
