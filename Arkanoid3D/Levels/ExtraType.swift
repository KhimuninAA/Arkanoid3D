//
//  ExtraType.swift
//  Arkanoid3D
//
//  Created by Алексей Химунин on 31.07.2023.
//

import Foundation

enum ExtraType {
    case none
    case score200
    case score500
    case score1000
    case score2000
    case score5000
    case score10000
    case goldShower
    case lengthen
    case shorten
    case life
    case slime
    case metal
    case ball
    case wall
    case frozen
    case weapon
    case random
    case fast
    case slow
    case joker
    case darkness
    case chaos
    case ghostPaddle
    case disable
    case timeAdd
    case explBall
    case bonusMagnet
    case malusMagnet
    case weakBall
}

extension ExtraType {
    static func type(by char: Character) -> ExtraType {
        if char == "0" {
            return .score200
        } else if char == "1" {
            return .score500
        } else if char == "2" {
            return .score1000
        } else if char == "3" {
            return .score2000
        } else if char == "4" {
            return .score5000
        } else if char == "5" {
            return .score10000
        } else if char == "+" {
            return .lengthen
        } else if char == "-" {
            return .shorten
        } else if char == "g" {
            return .goldShower
        } else if char == "l" {
            return .life
        } else if char == "s" {
            return .slime
        } else if char == "m" {
            return .metal
        } else if char == "b" {
            return .ball
        } else if char == "w" {
            return .wall
        } else if char == "f" {
            return .frozen
        } else if char == "p" {
            return .weapon
        } else if char == "?" {
            return .random
        } else if char == ">" {
            return .fast
        } else if char == "<" {
            return .slow
        } else if char == "j" {
            return .joker
        } else if char == "d" {
            return .darkness
        } else if char == "c" {
            return .chaos
        } else if char == "~" {
            return .ghostPaddle
        } else if char == "!" {
            return .disable
        } else if char == "&" {
            return .timeAdd
        } else if char == "*" {
            return .explBall
        } else if char == "}" {
            return .bonusMagnet
        } else if char == "{" {
            return .malusMagnet
        } else if char == "W" {
            return .weakBall
        }
        return .none
    }
}
