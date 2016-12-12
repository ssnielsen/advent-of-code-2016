//
//  Day7.swift
//  AdventOfCode2016
//
//  Created by Søren Nielsen on 12/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day7 {
    func run(with input: String) -> (part1: Int, part2: String) {
        let splitted = input.components(separatedBy: .newlines).filter { !$0.isEmpty }

        return (part1: part1(with: splitted), part2: part2(with: splitted))
    }

    func part1(with input: [String]) -> Int {
        let supportingIps = input.filter(supportsTLS)
        dump(supportingIps)
        return supportingIps.count
    }

    func part2(with input: [String]) -> String {
        var code = ""
        return code
    }

    private func supportsTLS(ip: String) -> Bool {
        return outsideSquares(ip: ip) && !insideSquares(ip: ip)
    }

    let abbaPattern = "(\\w)((?!\\1)\\w)\\2\\1"

    private func outsideSquares(ip: String) -> Bool {
        let pattern = abbaPattern
        return ip.range(of: pattern, options: String.CompareOptions.regularExpression) != nil
    }

    private func insideSquares(ip: String) -> Bool {
        let pattern = "\\[\\w*\(abbaPattern)\\w*\\]"
        return ip.range(of: pattern, options: String.CompareOptions.regularExpression) != nil
    }
}
