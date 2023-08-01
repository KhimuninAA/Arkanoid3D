//
//  RootView.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 01.08.2023.
//

import Foundation
import AppKit
import SceneKit

class RootView: NSView{
    var scene :SceneView?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView() {
        wantsLayer = true
        scene = SceneView(frame: .zero, options: nil)
        if let scene = scene {
            addSubview(scene)
        }
    }
    
    override func resizeSubviews(withOldSize oldSize: NSSize) {
        super.resizeSubviews(withOldSize: oldSize)
        
        let selfSize = frame.size
        
        scene?.frame = CGRect(x: 0, y: 0, width: selfSize.width, height: selfSize.height)
        scene?.resizeView()
    }
    
    func newGame() {
        scene?.newGame()
    }
}
