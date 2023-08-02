//
//  ScenesView.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 01.08.2023.
//

import Foundation
import SceneKit

class SceneView: SCNView {
    var cameraNode: SCNNode?
    var racketNode: SCNNode?
    var ballNode: BallNode?

    var minX: CGFloat = CGFLOAT_MAX
    var maxX: CGFloat = 0
    
    override init(frame: NSRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)
        initView()
    }
    
//    override func viewDidMoveToWindow() {
//         //disable retina
//         layer?.contentsScale = 1.0
//    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        self.delegate = self
        self.loops = true
        self.isPlaying = true
        
        //self.showsStatistics = true
        self.antialiasingMode = .multisampling8X
        
        scene = SCNScene(named: "Scene.scnassets/Scenes.scn")
        
        self.isJitteringEnabled = true
        preferredFramesPerSecond = 30

        scene?.physicsWorld.contactDelegate = self

        createRacket()
        createBall()
        initCameraNode()
        createGates()
        createItems()
    }
    
    func resizeView() {
        
    }

    func newGame() {
        
    }

    var gateDepth: CGFloat = -6
    var gateLeft: CGFloat = -2.5
}

extension SceneView {

    func createBall() {
        ballNode = BallNode.make()
        if let ballNode = ballNode {
            self.scene?.rootNode.addChildNode(ballNode)
        }
    }

    func createRacket() {
        let racketGeometry: SCNGeometry? = SCNBox(width: BrickNode.size.x, height: BrickNode.size.z, length: BrickNode.size.z, chamferRadius: 0.5 * BrickNode.size.z)

        racketNode = SCNNode(geometry: racketGeometry)
        if let racketNode = racketNode {
            self.scene?.rootNode.addChildNode(racketNode)
        }
    }

    func initCameraNode(){
        cameraNode = scene?.rootNode.childNode(withName: "camera", recursively: true)
    }

    func createGates() {
        let gateHeight = BrickNode.size.y * 23
        let gateVericalGeometry: SCNGeometry = SCNBox(width: BrickNode.size.x, height: gateHeight, length: BrickNode.size.z, chamferRadius: 0.02)
        let gateVericalLeftNode = SCNNode(geometry: gateVericalGeometry)
        gateVericalLeftNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: gateVericalGeometry, options: nil))

        gateVericalLeftNode.position = SCNVector3Make(gateLeft - BrickNode.size.x, 0.5 * gateHeight, gateDepth)
        self.scene?.rootNode.addChildNode(gateVericalLeftNode)

        let gateVericalRightNode = SCNNode(geometry: gateVericalGeometry)
        gateVericalRightNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: gateVericalGeometry, options: nil))
        gateVericalRightNode.position = SCNVector3Make(gateVericalLeftNode.position.x + 15 * BrickNode.size.x, 0.5 * gateHeight, gateDepth)
        self.scene?.rootNode.addChildNode(gateVericalRightNode)

        gateVericalLeftNode.physicsBody?.categoryBitMask = PhysicsContactMask.wall
        gateVericalLeftNode.physicsBody?.collisionBitMask = PhysicsContactMask.ball
        gateVericalLeftNode.physicsBody?.contactTestBitMask = PhysicsContactMask.ball


        gateVericalRightNode.physicsBody?.categoryBitMask = PhysicsContactMask.wall
        gateVericalRightNode.physicsBody?.collisionBitMask = PhysicsContactMask.ball
        gateVericalRightNode.physicsBody?.contactTestBitMask = PhysicsContactMask.ball

    }

    func createItems() {
        let bricksImage = NSImage(named: "bricks")!
        
        let levels = LevelUtils.getLevel(name: "LBreakout2") //LBreakout1 LBreakout2
        let level = levels[0]
        minX = CGFLOAT_MAX
        maxX = 0
        
        for brick in level.bricks {
            let item = BrickNode.make(type: brick.type)
            item.extraType = brick.extra
            item.geometry?.materials = BrickMaterialUtils.makeMaterials(by: brick.type, images: bricksImage)
            
            let x = gateLeft + BrickNode.size.x * CGFloat(brick.pos.x)
            let y = 4 * BrickNode.size.y + BrickNode.size.y * CGFloat(level.size.y - brick.pos.y)

            if minX > x {
                minX = x
            }

            if maxX < x {
                maxX = x
            }
            
            item.position = SCNVector3Make(x, y, gateDepth)
            self.scene?.rootNode.addChildNode(item)
        }

        let camX = minX + 0.5 * (maxX - minX)
        let camY = 0.5 * BrickNode.size.y * 23
        cameraNode?.position = SCNVector3Make(camX, camY, 0)
    }
}

extension SceneView: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    }
}

extension SceneView {

    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        let windowPoint = event.locationInWindow


        let pos = windowPoint.x/self.bounds.size.width

        let racketX = minX + pos * (maxX - minX)
        racketNode?.position = SCNVector3Make(racketX, 2 * BrickNode.size.y, gateDepth)

        if ballNode?.statys == .rocket {
            let ballDy = (racketNode?.boundingBox.max.y ?? 0) + 0.5 * BrickNode.size.y
            ballNode?.position = SCNVector3Make(racketX, 2 * BrickNode.size.y + ballDy, gateDepth)
        }
    }

    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        let result = hitTestResultForEvent(event)
        
        if let itemNode = result?.node as? BrickNode {
            print(itemNode)
        }

        if ballNode?.statys == .rocket {
            ballNode?.statys = .move
            //ballNode?.physicsBody?.type = .kinematic
            //ballNode?.physicsBody?.applyForce(SCNVector3(0.1, 0, -0.1), asImpulse: true)

            let racketX = racketNode?.position.x ?? 0
            let ballDy = (racketNode?.boundingBox.max.y ?? 0) + 0.5 * BrickNode.size.y
            //ballNode?.position = SCNVector3Make(racketX, 2 * BrickNode.size.y + ballDy, gateDepth)


            ballNode?.physicsBody?.velocity = SCNVector3(x: 0, y: 1, z: 0)
        } else if ballNode?.statys != .rocket {
            //ballNode?.physicsBody?.type = .static
            ballNode?.physicsBody?.velocity = SCNVector3(x: 0, y: 0, z: 0)
            ballNode?.statys = .rocket
        }
    }
    
    func hitTestResultForEvent(_ event: NSEvent) -> SCNHitTestResult?{
        let viewPoint = viewPointForEvent(event)
        let cgPoint = CGPoint(x: viewPoint.x, y: viewPoint.y)
        let points = self.hitTest(cgPoint, options: [:])
        return points.first
    }

    func viewPointForEvent(_ event: NSEvent) -> NSPoint{
        let windowPoint = event.locationInWindow
        let viewPoint = self.convert(windowPoint, from: nil)
        return viewPoint
    }

    override func updateTrackingAreas() {
        super.updateTrackingAreas()

        let opt = (
            NSTrackingArea.Options.mouseEnteredAndExited.rawValue |
                NSTrackingArea.Options.mouseMoved.rawValue |
                NSTrackingArea.Options.activeAlways.rawValue
        )

        let turnPageTrackingArea = NSTrackingArea(rect: self.bounds, options: NSTrackingArea.Options(rawValue: opt), owner: self, userInfo: nil)
        self.addTrackingArea(turnPageTrackingArea)
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        NSCursor.hide()
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        NSCursor.unhide()
    }

}

extension SceneView: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let ball = contact.nodeA as? BallNode ?? contact.nodeB as? BallNode
        if let ball = ball {
            //let speed = ball.physicsBody?.velocity
            //ball.physicsBody?.velocity = SCNVector3(x: 0, y: 0, z: 0)
        }
    }
}
