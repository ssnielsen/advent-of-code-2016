//
//  Day1.swift
//  AdventOfCode2016
//
//  Created by Soren Sonderby Nielsen on 01/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day1 {
    func run(with input: String) -> (part1: Int, part2: Int?) {
        let instructions = map(from: input)
        let result = compute(with: instructions)

        return result
    }

    func compute(with instructions: [Instruction]) -> (part1: Int, part2: Int?) {
        var position = Coordinate(x: 0, y: 0)
        var direction = Direction.north
        var history = [position]
        var part2: Int? = nil

        for instruction in instructions {
            switch instruction {
            case .rotate(let rotation):
                direction = rotate(with: rotation, while: direction)
            case .walk(let distance):
                for _ in 0..<distance {
                    let newPosition = walk(from: position, in: direction)
                    let hereBefore = history.contains {
                        $0.x == newPosition.x && $0.y == newPosition.y
                    }
                    if part2 == nil && hereBefore {
                        part2 = self.distance(from: newPosition)
                    }
                    position = newPosition
                    history.append(newPosition)
                }
            }
        }

        return (part1: distance(from: position), part2: part2)
    }

    func distance(from position: Coordinate) -> Int {
        return abs(position.x) + abs(position.y)
    }

    func rotate(with rotation: Rotation, while direction: Direction) -> Direction {
        switch (direction, rotation) {
        case (.east, .left),
             (.west, .right):
            return .north
        case (.east, .right),
             (.west, .left):
            return .south
        case (.north, .right),
             (.south, .left):
            return .east
        case (.north, .left),
             (.south, .right):
            return .west
        }
    }

    func walk(from position: Coordinate, in direction: Direction) -> Coordinate {
        var newPosition = position

        switch direction {
        case .east:  newPosition.x += 1
        case .south: newPosition.y -= 1
        case .west:  newPosition.x -= 1
        case .north: newPosition.y += 1
        }

        return newPosition
    }

    func map(from input: String) -> [Instruction] {
        let splitted = input.components(separatedBy: ",")
        let untyped = splitted.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        let typed = untyped.map { (s: String) -> [Day1.Instruction] in
            let distance = Int(s.substring(from: s.index(s.startIndex, offsetBy: 1)))!
            let rotation = s.hasPrefix("R") ? Rotation.right : Rotation.left
            let rotationInstruction = Instruction.rotate(rotation: rotation)
            let walking = Instruction.walk(distance: distance)
            return [rotationInstruction, walking]
        }.flatMap { $0 }

        return typed
    }

    enum Instruction {
        case walk(distance: Int)
        case rotate(rotation: Rotation)
    }

    enum Rotation {
        case left, right
    }

    enum Direction {
        case east, south, west, north
    }

    struct Coordinate {
        var x: Int
        var y: Int
    }
}
