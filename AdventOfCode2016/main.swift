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
        let path = "/Users/Soren/Developer/advent-of-code-2016/Input/\(day)"
        //let path = "/Users/soren/econ-source/advent-of-code-2016/Input/\(day)"
        let input = try String(contentsOfFile: path, encoding: .utf8)
        return input
    } catch {
        print(error)
        return nil
    }
}

func matches(for regex: String, in text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let nsString = text as NSString
        let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
        return results.map { nsString.substring(with: $0.range)}
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

let input = loadInput(for: 5)!
//let input = "aaaaa-bbb-z-y-x-123[abxyz]"
let result = Day5().run(with: input)
print(result)


/* TEMPLATE
 struct Day4 {
 func run(with input: String) -> (part1: String, part2: String) {
 let splitted = input.components(separatedBy: .newlines).filter { !$0.isEmpty }

 return (part1: part1(with: splitted), part2: part2(with: splitted))
 }

 func part1(with input: [String]) -> String {
 var code = ""
 return code
 }

 func part2(with input: [String]) -> String {
 var code = ""
 return code
 }
 }

 */
