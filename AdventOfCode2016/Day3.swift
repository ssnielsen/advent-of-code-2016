//
//  Day3.swift
//  AdventOfCode2016
//
//  Created by Soren Sonderby Nielsen on 04/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day3 {
    func run(with input: String) -> (part1: Int, part2: Int) {
        let splitted = input.components(separatedBy: .newlines).filter { !$0.isEmpty }
        
        return (part1: part1(with: splitted), part2: part2(with: splitted))
    }
    
    func part1(with input: [String]) -> Int {
        let data = input
        .map { (line: String) -> [Int] in
            let result = matches(for: "\\d+", in: line)
            return [Int(result[0])!, Int(result[1])!, Int(result[2])!]
        }
        .filter { triangle in
            let sorted = triangle.sorted()
            return sorted[0] + sorted[1] > sorted[2]
        }
        
        return data.count
    }
    
    
    func part2(with input: [String]) -> Int {
        return 0
    }
}
