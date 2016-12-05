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
            let countedLetters = room.name.map { namePart in
                return (namePart.characters.first!, namePart.characters.count)
            }
            let sortedCountedLetters = countedLetters.sorted { x, y in
                return x.1 < y.1
            }
            let a = sortedCountedLetters[0..<5].map { $0.0 }.flatMap { $0 }

            return sum + (String(a) == room.checksum ? room.sectorId : 0)
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
        let checksum = splitted[1]
        let name = Array(nameAndSectorId[0..<(nameAndSectorId.count-1)])
        let sectorId = Int(nameAndSectorId.last!)!

        return Room(name: name, sectorId: sectorId, checksum: checksum)
    }


    struct Room {
        var name: [String]
        var sectorId: Int
        var checksum: String
    }
}
