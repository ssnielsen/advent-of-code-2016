//
//  Day2.swift
//  AdventOfCode2016
//
//  Created by Søren Nielsen on 02/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day2 {
    func run(with input: String) -> (part1: String, part2: String?) {
        let splitted = input.components(separatedBy: .newlines).filter { !$0.isEmpty }
        
        return (part1: part1(with: splitted), part2: nil)
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
}
