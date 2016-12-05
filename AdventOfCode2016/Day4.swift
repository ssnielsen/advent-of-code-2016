//
//  Day4.swift
//  AdventOfCode2016
//
//  Created by Søren Nielsen on 05/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day4 {
    func run(with input: String) -> (part1: String, part2: String) {
        let splitted = input.components(separatedBy: .newlines).filter { !$0.isEmpty }
        let rooms = splitted.map(parse)

        return (part1: part1(with: rooms), part2: part2(with: rooms))
    }

    func part1(with rooms: [Room]) -> String {
        let sumOfIds = rooms.reduce(0) { sum, room in
            return sum + (room.isValid ? room.sectorId : 0)
        }

        return String(sumOfIds)
    }

    func part2(with rooms: [Room]) -> String {
        let validRooms = rooms.filter { $0.isValid }
        
        let secretRoom = validRooms.first { $0.shiftedName == "northpole object storage" }
        
        return String(describing: secretRoom?.sectorId)
    }
    
    private func parse(with input: String) -> Room {
        var splitted = input.components(separatedBy: "[")
        var nameAndSectorId = splitted[0].components(separatedBy: "-")
        let checksum = splitted[1].replacingOccurrences(of: "]", with: "")
        let name = Array(nameAndSectorId[0..<(nameAndSectorId.count-1)])
        let sectorId = Int(nameAndSectorId.last!)!

        return Room(name: name, sectorId: sectorId, checksum: checksum)
    }

    struct Room {
        var name: [String]
        var sectorId: Int
        var checksum: String
        
        var isValid: Bool {
            let countedLetters = self.name.joined().characters.reduce([String:Int]()) { dict, letter in
                var newDict = dict
                let letterKey = String(letter)
                newDict[letterKey] = (newDict[letterKey] ?? 0) + 1
                return newDict
                }
                .sorted { kvp1, kvp2 in
                    return kvp1.value < kvp2.value
            }
            
            let sortedCountedLetters = countedLetters.sorted { x, y in
                if x.value == y.value {
                    return x.key < y.key
                } else {
                    return x.value > y.value
                }
            }
            
            let mostAppearing = sortedCountedLetters[0..<5].map { $0.0 }.joined()
            
            return mostAppearing == self.checksum
        }
        
        var shiftedName: String {
            return name.map { shift(string: $0, by: sectorId) }.joined(separator: " ")
        }
        
        func shift(string: String, by distance: Int) -> String {
            let valueA = "a".unicodeScalars.first!.value
            
            return string.unicodeScalars
                .map {
                    valueA + (($0.value - valueA + UInt32(distance)) % 26)
                }
                .reduce("") {
                    $0 + String(Character(UnicodeScalar($1)!))
                }
        }
    }
}
