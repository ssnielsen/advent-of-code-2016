//
//  Day8.swift
//  AdventOfCode2016
//
//  Created by Soren Sonderby Nielsen on 17/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day8 {
    func run(with input: String) -> (part1: Int, part2: Int) {
        let splitted = input.components(separatedBy: .newlines).filter { !$0.isEmpty }
        
        return (part1: part1(with: splitted), part2: -1)
    }
    
    func part1(with input: [String]) -> Int {
        let screen = Array(repeating: Array(repeating: false, count: 6), count: 50)
        
        let instructions = parse(input: input)
        
        let resultingScreen = instructions.reduce(screen) { oldScreen, instruction in
            var newScreen = oldScreen
            switch instruction {
            case .on(let width, let height):
                for column in 0..<width {
                    for row in 0..<height {
                        newScreen[column][row] = true
                    }
                }
            case .rotateRow(let rowNo, let positions):
                let rowToRotate = row(no: rowNo, in: oldScreen)
                let rotatedRow = rotate(rowToRotate, by: positions)
                newScreen = insert(row: rotatedRow, into: oldScreen, at: rowNo)
            case .rotateColumn(let columnNo, let positions):
                let columnToRotate = column(no: columnNo, in: oldScreen)
                let rotatedColumn = rotate(columnToRotate, by: positions)
                newScreen = insert(column: rotatedColumn, into: oldScreen, at: columnNo)
            }
            return newScreen
        }
        
        printScreen(transpose(resultingScreen))
        
        let lightsOn = resultingScreen
            .flatMap { $0 }
            .reduce(0) { $0 + ($1 ? 1 : 0) }
        
        return lightsOn
    }
    
    func printScreen(_ screen: [[Bool]]) {
        for (_, ex) in screen.enumerated() {
            print(ex.reduce("") { $0 + ($1 ? "#" : ".") })
        }
    }
    
    private func parse(input: [String]) -> [Instruction] {
        return input.map {
            if $0.hasPrefix("rect") {
                let groups = matches(for: "\\d+", in: $0)
                let width = Int(groups[0])!
                let height = Int(groups[1])!
                return .on(width: width, height: height)
            } else if $0.hasPrefix("rotate column") {
                let groups = matches(for: "\\d+", in: $0)
                let column = Int(groups[0])!
                let positions = Int(groups[1])!
                return .rotateColumn(column: column, positions: positions)
            } else if $0.hasPrefix("rotate row") {
                let groups = matches(for: "\\d+", in: $0)
                let row = Int(groups[0])!
                let positions = Int(groups[1])!
                return .rotateRow(row: row, positions: positions)
            } else {
                print("ERROR for input \($0)")
                exit(1)
            }
        }
    }
    
    private func row<T>(no rowNo: Int, in array: [[T]]) -> [T] {
        return (0..<array.count).map { array[$0][rowNo] }
    }
    
    private func column<T>(no columnNo: Int, in array: [[T]]) -> [T] {
        return array[columnNo]
    }
    
    private func insert<T>(column: [T], into array: [[T]], at columnNo: Int) -> [[T]] {
        var newArray = array
        for (index, element) in column.enumerated() {
            newArray[columnNo][index] = element
        }
        return newArray
    }
    
    private func insert<T>(row: [T], into array: [[T]], at rowNo: Int) -> [[T]] {
        var newArray = array
        for (index, element) in row.enumerated() {
            newArray[index][rowNo] = element
        }
        return newArray
    }
    
    private func rotate<T>(_ array: [T], by positions: Int) -> [T] {
        let pivot = array.count - (positions % array.count)
        return Array(array.suffix(from: pivot) + array.prefix(upTo: pivot))
    }
    
    private func transpose(_ matrix: [[Bool]]) -> [[Bool]] {
        var result = Array(repeating: Array(repeating: false, count: matrix.count), count: matrix[0].count)
        for x in 0..<matrix[0].count {
            for y in 0..<matrix.count {
                result[x][y] = matrix[y][x]
            }
        }
        return result
    }
    
    enum Instruction {
        case on(width: Int, height: Int)
        case rotateRow(row: Int, positions: Int)
        case rotateColumn(column: Int, positions: Int)
    }
}
