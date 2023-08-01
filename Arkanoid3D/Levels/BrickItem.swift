//
//  BrickItem.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 01.08.2023.
//

import Foundation

struct BrickItem {
    let pos: BrickPos
    let type: BrickType
    var extra: ExtraType
}

extension Array where Iterator.Element == BrickItem {
    mutating func updateExtraType(_ extraType: ExtraType, by pos: BrickPos) {
        if let index = self.firstIndex(where: {$0.pos == pos}) {
            self[index].extra = extraType
        }
    }
}
