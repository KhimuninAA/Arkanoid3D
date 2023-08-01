//
//  BrickNode.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 01.08.2023.
//

import Foundation
import SceneKit

class BrickNode: SCNNode {
    private static var itemIndex: Int = 0
    var type: BrickType
    var extraType: ExtraType = .none
    
    static var size: SCNVector3 {
        return SCNVector3(x: 0.4, y: 0.2, z: 0.1)
    }
    
    init(geometry: SCNGeometry?, type: BrickType) {
        self.type = type
        super.init()
        BrickNode.itemIndex += 1
        self.name = "\(BrickNode.itemIndex)"
        self.geometry = geometry
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BrickNode {
    static func make(type: BrickType) -> BrickNode {
        let itemGeometry: SCNGeometry? = SCNBox(width: BrickNode.size.x, height: BrickNode.size.y, length: BrickNode.size.z, chamferRadius: 0.02)
        let itemNode = BrickNode(geometry: itemGeometry, type: type)

        //itemNode.geometry?.materials = BrickMaterialUtils.makeMaterials(by: type)

        return itemNode
    }
}
