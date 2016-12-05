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
            .filter(isTriangle)

        return data.count
    }

    func part2(with input: [String]) -> Int {
        let chunked = input
            .map { (line: String) -> [Int] in
                let result = matches(for: "\\d+", in: line)
                return [Int(result[0])!, Int(result[1])!, Int(result[2])!]
            }
            .chunk(3)

        let pivoted = chunked
            .map { (arr: [[Int]]) -> [[Int]] in
                return [
                    [arr[2][2], arr[1][2], arr[0][2]],
                    [arr[2][1], arr[1][1], arr[0][1]],
                    [arr[2][0], arr[1][0], arr[0][0]]
                ]
        }

        let flattened = pivoted.flatMap { $0 }

        let triangles = flattened.filter(isTriangle)

        return triangles.count
    }

    private func isTriangle(_ triangle: [Int]) -> Bool {
        let sorted = triangle.sorted()
        return sorted[0] + sorted[1] > sorted[2]
    }
}

extension Array {
    func chunk(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map({ (startIndex) -> [Element] in
            let endIndex = (startIndex.advanced(by: chunkSize) > self.count)
                ? self.count-startIndex
                : chunkSize
            return Array(self[startIndex..<startIndex.advanced(by: endIndex)])
        })
    }
}
