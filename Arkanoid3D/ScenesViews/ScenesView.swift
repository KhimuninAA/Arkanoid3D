//
//  ScenesView.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 01.08.2023.
//

import Foundation
import SceneKit

class SceneView: SCNView {
    
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
        
        createItems()
    }
    
    func resizeView() {
        
    }

    func newGame() {
        
    }
}

extension SceneView {
    func createItems() {
//        let levels = LevelUtils.getLevel(name: "LBreakout2")
//        print(levels)
        let bricksImage = NSImage(named: "bricks")!
        
        let levels = LevelUtils.getLevel(name: "LBreakout2") //LBreakout1 LBreakout2
        let level = levels[0]
        
        for brick in level.bricks {
            let item = BrickNode.make(type: brick.type)
            item.extraType = brick.extra
            item.geometry?.materials = BrickMaterialUtils.makeMaterials(by: brick.type, images: bricksImage)
            
            let x = -2.5 + BrickNode.size.x * CGFloat(brick.pos.x)
            let y = 7 - BrickNode.size.y * CGFloat(brick.pos.y)
            
            item.position = SCNVector3Make(x, y, -6)
            self.scene?.rootNode.addChildNode(item)
        }
    }
}

extension SceneView: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    }
}

extension SceneView {
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        let result = hitTestResultForEvent(event)
        
        if let itemNode = result?.node as? BrickNode {
            print(itemNode)
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
}
