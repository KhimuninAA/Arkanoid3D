//
//  Storage.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 01.08.2023.
//

import Foundation

class Storage {
    private static func storage() -> UserDefaults {
        return UserDefaults.standard
    }

    static func save(windowFrame: CGRect) {
        let storage = storage()
        storage.setValue(windowFrame.minX, forKey: "windowFrameX")
        storage.setValue(windowFrame.minY, forKey: "windowFrameY")
        storage.setValue(windowFrame.width, forKey: "windowFrameW")
        storage.setValue(windowFrame.height, forKey: "windowFrameH")
    }

    static func readWindowFrame() -> CGRect {
        let storage = storage()
        let windowFrameX = storage.integer(forKey: "windowFrameX")
        let windowFrameY = storage.integer(forKey: "windowFrameY")
        let windowFrameW = storage.integer(forKey: "windowFrameW")
        let windowFrameH = storage.integer(forKey: "windowFrameH")
        let frame = CGRect(x: windowFrameX, y: windowFrameY, width: windowFrameW, height: windowFrameH)
        return frame
    }
}
