//
//  Day9.swift
//  AdventOfCode2016
//
//  Created by Soren Sonderby Nielsen on 17/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day9 {
    func run(with input: String) -> (part1: Int, part2: Int) {
        let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)
        return (part1: part1(with: trimmedInput), part2: part2(with: trimmedInput))
    }
    
    func part1(with input: String) -> Int {
        return decompress(string: input)
    }
    
    func part2(with input: String) -> Int {
        let result = decompress(string: input, recursive: true)
        return result
    }
    
    private func decompress(string: String, recursive: Bool = false) -> Int {
        var result = 0
        let ruleRegex = "\\(\\d+x\\d+\\)"
        
        
        var searchSpace = string
        
        while true {
            guard let ruleRange = searchSpace.range(of: ruleRegex, options: .regularExpression) else {
                let finalResult = (result + searchSpace.count)
                return finalResult
            }
            
            let ruleString = String(searchSpace[ruleRange])
            
            let searchSpaceSplitted = searchSpace.components(separatedBy: ruleString)
            
            let beforeRule = searchSpaceSplitted.first!
            result += beforeRule.count
            
            let ruleSearchSpace = searchSpace[searchSpace.index(searchSpace.startIndex, offsetBy: (beforeRule + ruleString).count)...]
            
            let rules = matches(for: "\\d+", in: ruleString)
            let distance = Int(rules[0])!
            let repeated = Int(rules[1])!
            let toRepeat = ruleSearchSpace[..<ruleSearchSpace.index(ruleSearchSpace.startIndex, offsetBy: distance)]
            let repeatedString = String(repeating: String(toRepeat), count: repeated)
            
            result += (recursive ? decompress(string: repeatedString, recursive: recursive) : repeatedString.count)
            
            searchSpace = String(ruleSearchSpace[ruleSearchSpace.index(ruleSearchSpace.startIndex, offsetBy: distance)...])
        }
    }
}
