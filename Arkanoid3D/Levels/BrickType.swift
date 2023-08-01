//
//  BrickType.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 31.07.2023.
//

import Foundation

///* brick conversion table: brick id, char */
//Brick_Conv brick_conv_table[BRICK_COUNT] = {
//    { 'E', MAP_WALL,        0, -1, 0 },
//    { '#', MAP_BRICK,       1, -1, 1000 },
//    { '@', MAP_BRICK_CHAOS, 2, -1, 1000 },
//    { 'a', MAP_BRICK,       3,  1, BRICK_SCORE * 1 },
//    { 'b', MAP_BRICK,       4,  2, BRICK_SCORE * 2 },
//    { 'c', MAP_BRICK,       5,  3, BRICK_SCORE * 3 },
//    { 'v', MAP_BRICK,       6,  4, BRICK_SCORE * 4 },
//    { 'x', MAP_BRICK_HEAL,  7,  1, BRICK_SCORE * 2},
//    { 'y', MAP_BRICK_HEAL,  8,  2, BRICK_SCORE * 4},
//    { 'z', MAP_BRICK_HEAL,  9,  3, BRICK_SCORE * 6},
//    { 'd', MAP_BRICK,      10,  1, BRICK_SCORE },
//    { 'e', MAP_BRICK,      11,  1, BRICK_SCORE },
//    { 'f', MAP_BRICK,      12,  1, BRICK_SCORE },
//    { 'g', MAP_BRICK,      13,  1, BRICK_SCORE },
//    { 'h', MAP_BRICK,      14,  1, BRICK_SCORE },
//    { 'i', MAP_BRICK,      15,  1, BRICK_SCORE },
//    { 'j', MAP_BRICK,      16,  1, BRICK_SCORE },
//    { 'k', MAP_BRICK,      17,  1, BRICK_SCORE },
//    { '*', MAP_BRICK_EXP,  18,  1, BRICK_SCORE * 2 },
//    { '!', MAP_BRICK_GROW, GROW_BRICK_ID,  1, BRICK_SCORE * 2 },
//};

enum BrickType {
    case none
    case wall
    case brick1
    case brick_chaos
    case brick3
    case brick4
    case brick5
    case brick6
    case brick_heal7
    case brick_heal8
    case brick_heal9
    case brick10
    case brick11
    case brick12
    case brick13
    case brick14
    case brick15
    case brick16
    case brick17
    case brick_exp
    case brick_grow
}

extension BrickType {
    func index() -> Double {
        switch self{
        case .none:
            return 0
        case .wall:
            return 0
        case .brick1:
            return 1
        case .brick_chaos:
            return 2
        case .brick3:
            return 3
        case .brick4:
            return 4
        case .brick5:
            return 5
        case .brick6:
            return 6
        case .brick_heal7:
            return 7
        case .brick_heal8:
            return 8
        case .brick_heal9:
            return 9
        case .brick10:
            return 10
        case .brick11:
            return 11
        case .brick12:
            return 12
        case .brick13:
            return 13
        case .brick14:
            return 14
        case .brick15:
            return 15
        case .brick16:
            return 16
        case .brick17:
            return 17
        case .brick_exp:
            return 18
        case .brick_grow:
            return 19
        }
    }
}

extension BrickType {
    static func getType(by char: Character) -> BrickType {
        if char == "E" {
            return .wall
        } else if char == "#" {
            return .brick1
        } else if char == "@" {
            return .brick_chaos
        } else if char == "a" {
            return .brick3
        } else if char == "b" {
            return .brick4
        } else if char == "c" {
            return .brick5
        } else if char == "v" {
            return .brick6
        } else if char == "x" {
            return .brick_heal7
        } else if char == "y" {
            return .brick_heal8
        } else if char == "z" {
            return .brick_heal9
        } else if char == "d" {
            return .brick10
        } else if char == "e" {
            return .brick11
        } else if char == "f" {
            return .brick12
        } else if char == "g" {
            return .brick13
        } else if char == "h" {
            return .brick14
        } else if char == "i" {
            return .brick15
        } else if char == "j" {
            return .brick16
        } else if char == "k" {
            return .brick17
        } else if char == "*" {
            return .brick_exp
        } else if char == "!" {
            return .brick_grow
        }
        return .none
    }
}
