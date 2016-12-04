//
//  Day2.swift
//  AdventOfCode2016
//
//  Created by Søren Nielsen on 02/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day2 {
    func run(with input: String) -> (part1: String, part2: String) {
        let splitted = input.components(separatedBy: .newlines).filter { !$0.isEmpty }

        return (part1: part1(with: splitted), part2: part2(with: splitted))
    }

    func part1(with input: [String]) -> String {
        var code = ""
        var finger = 5

        for line in input {
            for instruction in line.characters {
                switch instruction {
                case "R" where finger % 3 != 0: finger += 1
                case "L" where finger % 3 != 1: finger -= 1
                case "U" where finger > 3: finger -= 3
                case "D" where finger < 7: finger += 3
                default: print("ERROR IN INPUT: \(instruction) when finger is \(finger)")
                }
            }
            code += String(finger)
        }

        return code
    }
    
    func part2(with input: [String]) -> String {
        var code = ""
        var finger = (x: 1, y: 3)
        
        let grid = [
            [nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, "1", nil, nil, nil],
            [nil, nil, "2", "3", "4", nil, nil],
            [nil, "5", "6", "7", "8", "9", nil],
            [nil, nil, "A", "B", "C", nil, nil],
            [nil, nil, nil, "D", nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil],
        ]
        
        let moves = [
            "R": (x: 1, y: 0),
            "L": (x: -1, y: 0),
            "U": (x: 0, y: -1),
            "D": (x: 0, y: 1)
        ]
        
        for line in input {
            for instruction in line.characters {
                guard let move = moves[String(instruction)] else {
                    print("ERROR. Could not find move")
                    continue
                }
                
                let afterMove = finger + move
                
                if grid[afterMove.y][afterMove.x] != nil {
                    finger = afterMove
                }
            }
            
            code += grid[finger.y][finger.x]!
        }
        
        return code
    }
}

func +(lhs: (x: Int, y: Int), rhs: (x: Int, y: Int)) -> (x: Int, y: Int) {
    return (x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

