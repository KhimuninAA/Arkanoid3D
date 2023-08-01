//
//  LevelUtils.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 31.07.2023.
//

import Foundation

struct BrickPos: Equatable {
    let x: Int
    let y: Int

    static func ==(lhs: BrickPos, rhs: BrickPos) -> Bool {
            return (lhs.x == rhs.x && lhs.y == rhs.y)
    }
}

struct LevelItem {
    var name: String = ""
    var bricks: [BrickItem] = [BrickItem]()
}

class LevelUtils {

    enum LevelType {
        case none
        case level
        case bricks
        case bonus
    }

    private static func load(name: String) -> String? {
        if let filepath = Bundle.main.path(forResource: name, ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }

    private static func getType(by str: String) -> LevelType {
        if str.prefix(6) == "Level:" {
            return .level
        }
        if str.prefix(7) == "Bricks:" {
            return .bricks
        }
        if str.prefix(6) == "Bonus:" {
            return .bonus
        }
        return .none
    }

    private static func getSpace(by content: String?) -> String {
        if let content = content, content.count > 0 {
            return " "
        }
        return ""
    }

    static func getLevel(name: String) -> [LevelItem] {
        var levels = [LevelItem]()
        var rowIndex: Int = 0
        var posIndex: Int = 0
        if let str = load(name: name) {
            var levelItem: LevelItem? = nil
            let rows = str.components(separatedBy: "\n")
            var currentType: LevelType = .none
            for row in rows {
                let type = getType(by: row)
                switch type {
                case .none:
                    switch currentType {
                    case .none:
                        break
                    case .level:
                        let addStr = getSpace(by: levelItem?.name) + row
                        levelItem?.name += addStr
                    case .bricks:
                        for char in row {
                            let type = BrickType.getType(by: char)
                            if type != .none {
                                let pos = BrickPos(x: posIndex, y: rowIndex)
                                let brick = BrickItem(pos: pos, type: type, extra: .none)
                                levelItem?.bricks.append(brick)
                            }
                            posIndex += 1
                        }
                        posIndex = 0
                        rowIndex += 1
                    case .bonus:
                        for char in row {
                            let extraType = ExtraType.type(by: char)
                            let pos = BrickPos(x: posIndex, y: rowIndex)
                            levelItem?.bricks.updateExtraType(extraType, by: pos)
                            posIndex += 1
                        }
                        posIndex = 0
                        rowIndex += 1
                    }
                case .level:
                    currentType = type
                    if let levelItem = levelItem {
                        levels.append(levelItem)
                    }
                    levelItem = LevelItem()
                case .bricks:
                    rowIndex = 0
                    posIndex = 0
                    currentType = type
                case .bonus:
                    rowIndex = 0
                    posIndex = 0
                    currentType = type
                }
            }
        }
        return levels
    }
}
