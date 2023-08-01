//
//  BrickMaterialUtils.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 01.08.2023.
//

import Foundation
import SceneKit

class BrickMaterialUtils {
    //private static let bricksImage = NSImage(named: "bricks")
    //private static let extrasImage = NSImage(named: "extras")
    
    private static func image(from images: NSImage, type: BrickType) -> NSImage? {
        var imageRect = CGRect(origin: .zero, size: images.size)
        if let cgImages = images.cgImage(forProposedRect: &imageRect, context: nil, hints: nil) {
            let rect = CGRect(x: type.index() * 40, y: 0, width: 40, height: 20)
            if let cgImage = cgImages.cropping(to: rect) {
                let image = NSImage(cgImage: cgImage, size: CGSize(width: 40, height: 20))
                return image
            }
        }
        return nil
    }
    
    static func makeMaterials(by type: BrickType, images: NSImage) -> [SCNMaterial] {
        var materials = [SCNMaterial]()
        
        let material1 = SCNMaterial()
        material1.diffuse.contents = image(from: images, type: type)
        materials.append(material1)
        
        let material2 = SCNMaterial()
        material2.diffuse.contents = NSColor.white
        materials.append(material2)
        
        let material3 = SCNMaterial()
        material3.diffuse.contents = NSColor.white
        materials.append(material3)
        
        let material4 = SCNMaterial()
        material4.diffuse.contents = NSColor.white
        materials.append(material4)
        
        let material5 = SCNMaterial()
        material5.diffuse.contents = NSColor.white
        materials.append(material5)
        
        let material6 = SCNMaterial()
        material6.diffuse.contents = NSColor.white
        materials.append(material6)
        
        return materials
    }
}
