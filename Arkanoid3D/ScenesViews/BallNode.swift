//
//  BallNode.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 02.08.2023.
//

import Foundation
import SceneKit

enum BallStatys {
    case none
    case rocket
    case move
}

class BallNode: SCNNode {
    var statys: BallStatys = .none

    init(geometry: SCNGeometry?, statys: BallStatys) {
        self.statys = statys
        super.init()
        self.geometry = geometry
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BallNode {
    static func make() -> BallNode {
        let ballGeometry: SCNSphere = SCNSphere(radius: 0.5 * BrickNode.size.y)
        ballGeometry.segmentCount = 90
        let ballNode = BallNode(geometry: ballGeometry, statys: .rocket)
        ballNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: ballGeometry, options: nil))
        ballNode.physicsBody?.isAffectedByGravity = false

        ballNode.physicsBody?.categoryBitMask = PhysicsContactMask.ball
        ballNode.physicsBody?.collisionBitMask = PhysicsContactMask.brick | PhysicsContactMask.wall | PhysicsContactMask.racket
        ballNode.physicsBody?.contactTestBitMask = PhysicsContactMask.brick | PhysicsContactMask.wall | PhysicsContactMask.racket

        ballNode.physicsBody?.mass = 2.2 //10.2
        ballNode.physicsBody?.restitution = 1
        ballNode.physicsBody?.damping = 0
        ballNode.physicsBody?.friction = 0 //0.5
        

        return ballNode
    }
}
