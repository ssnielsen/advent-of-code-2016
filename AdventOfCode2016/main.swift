//
//  main.swift
//  AdventOfCode2016
//
//  Created by Soren Sonderby Nielsen on 01/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

func loadInput(for day: Int) -> String? {
    do {
        //let input = try String(contentsOfFile: "/Users/Soren/Developer/AdventOfCode2016/Input/\(day)", encoding: .utf8)
        let input = try String(contentsOfFile: "/Users/soren/econ-source/advent-of-code-2016/Input/\(day)", encoding: .utf8)
        return input
    } catch {
        print(error)
        return nil
    }
}

let input = loadInput(for: 2)!
//let input = "ULL\nRRDDD\nLURDL\nUUUUD"
let result = Day2().run(with: input)
print(result)
