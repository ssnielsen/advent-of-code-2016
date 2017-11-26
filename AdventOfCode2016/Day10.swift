//
//  Day10.swift
//  AdventOfCode2016
//
//  Created by Soren Sonderby Nielsen on 20/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day10 {
    func run(with input: String) -> (part1: String, part2: String) {
        let splitted = input.components(separatedBy: .newlines).filter { !$0.isEmpty }
        
        return (part1: part1(with: splitted), part2: part2(with: splitted))
    }
    
    func part1(with input: [String]) -> String {
        let code = ""
        return code
    }
    
    func part2(with input: [String]) -> String {
        let code = ""
        return code
    }
    
    class Bot {
        var id: Int
        var high: Int?
        var low: Int?
        var chips = [Int]() {
            didSet {
                
            }
        }
        
        init (id: Int) {
            self.id = id
        }
    }
}
