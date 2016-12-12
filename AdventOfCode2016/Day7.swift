//
//  Day7.swift
//  AdventOfCode2016
//
//  Created by Søren Nielsen on 12/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day7 {
    func run(with input: String) -> (part1: Int, part2: Int) {
        let splitted = input.components(separatedBy: .newlines).filter { !$0.isEmpty }

        return (part1: part1(with: splitted), part2: part2(with: splitted))
    }

    func part1(with input: [String]) -> Int {
        let supportingIps = input.filter(supportsTLS)
        dump(supportingIps)
        return supportingIps.count
    }
    
    private func supportsTLS(ip: String) -> Bool {
        let abbaPattern = "(\\w)((?!\\1)\\w)\\2\\1"
        return ip.contains(pattern: abbaPattern) && !ip.contains(pattern: "\\[\\w*\(abbaPattern)\\w*\\]")
    }
    
    func part2(with input: [String]) -> Int {
        let supportingIps = input.filter(supportsSSL)
        dump(supportingIps)
        return supportingIps.count
    }
    
    private func supportsSSL(ip: String) -> Bool {
        let pattern = "(.)((?!\\1)\\w)\\1.*\\[.*\\2\\1\\2\\w*\\]|\\[\\w*(\\w)((?!\\3)\\w)\\3\\w*\\].*\\4\\3\\4"
        return ip.contains(pattern: pattern)
    }
}

private extension String {
    func contains(pattern: String) -> Bool {
        return self.range(of: pattern, options: String.CompareOptions.regularExpression) != nil
    }
}
