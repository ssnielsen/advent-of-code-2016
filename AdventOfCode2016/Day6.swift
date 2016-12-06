//
//  Day6.swift
//  AdventOfCode2016
//
//  Created by Soren Sonderby Nielsen on 06/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day6 {
    func run(with input: String) -> (part1: String, part2: String) {
        let splitted = input.components(separatedBy: .newlines).filter { !$0.isEmpty }
        
        return (part1: part1(with: splitted), part2: part2(with: splitted))
    }
    
    func part1(with input: [String]) -> String {
        var letterCounts = Array(repeating: [Character:Int](), count: input.first!.characters.count)
        
        for message in input {
            for (index, letter) in message.characters.enumerated() {
                letterCounts[index][letter] = (letterCounts[index][letter] ?? 0) + 1
            }
        }
        
        let mostAppearingLetters = letterCounts.map { positionCount in
            return positionCount.max(by: { a, b in
                return a.value < b.value
            })!.key
        }
        
        return String(mostAppearingLetters)
    }
    
    func part2(with input: [String]) -> String {
        var letterCounts = Array(repeating: [Character:Int](), count: input.first!.characters.count)
        
        for message in input {
            for (index, letter) in message.characters.enumerated() {
                letterCounts[index][letter] = (letterCounts[index][letter] ?? 0) + 1
            }
        }
        
        let mostAppearingLetters = letterCounts.map { positionCount in
            return positionCount.max(by: { a, b in
                return a.value > b.value
            })!.key
        }
        
        return String(mostAppearingLetters)
    }
}
