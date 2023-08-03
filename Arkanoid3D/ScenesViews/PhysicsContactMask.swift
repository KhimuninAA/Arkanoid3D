//
//  PhysicsContactMask.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 02.08.2023.
//

import Foundation

struct PhysicsContactMask{
    static let ball = 1 << 1
    static let brick = 1 << 2
    static let racket = 1 << 2
    static let wall = 1 << 3
}
