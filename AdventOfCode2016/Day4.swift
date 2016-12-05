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
            let countedLetters = room.name.characters.reduce([String:Int]()) { dict, letter in
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
            
            return sum + (mostAppearing == room.checksum ? room.sectorId : 0)
        }


        return String(sumOfIds)
    }

    func part2(with rooms: [Room]) -> String {
        var code = ""
        return code
    }

    func parse(with input: String) -> Room {
        var splitted = input.components(separatedBy: "[")
        var nameAndSectorId = splitted[0].components(separatedBy: "-")
        let checksum = splitted[1].replacingOccurrences(of: "]", with: "")
        let name = Array(nameAndSectorId[0..<(nameAndSectorId.count-1)]).joined()
        let sectorId = Int(nameAndSectorId.last!)!

        return Room(name: name, sectorId: sectorId, checksum: checksum)
    }


    struct Room {
        var name: String
        var sectorId: Int
        var checksum: String
    }
}
