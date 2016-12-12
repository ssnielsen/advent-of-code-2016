//
//  Day5.swift
//  AdventOfCode2016
//
//  Created by Soren Sonderby Nielsen on 05/12/2016.
//  Copyright © 2016 sonderby Inc. All rights reserved.
//

import Foundation

struct Day5 {
    func run(with input: String) -> (part1: String, part2: String) {
        let sanitized = input.trimmingCharacters(in: .whitespacesAndNewlines)
        return (part1: "", part2: part2(with: sanitized))
    }

    let codeLength = 8
    let fiveZeroes = "00000"
    
    func part1(with input: String) -> String {
        var code = ""
        var index = 0

        while (true) {
            let hash = MD5String(string: "\(input)\(index)")
            
            if hash.hasPrefix(fiveZeroes) {
                code += hash[hash.index(hash.startIndex, offsetBy: 5)...hash.index(hash.startIndex, offsetBy: 5)]
                print("Code is now \(code)")
            }
            
            if code.characters.count == codeLength {
                break
            }
            
            index += 1
        }
        
        return code
    }
    
    func part2(with input: String) -> String {
        var code: [String?] = Array(repeating: nil, count: codeLength)
        var index = 0

        while (true) {
            let hash = MD5String(string: "\(input)\(index)")

            if hash.hasPrefix(fiveZeroes) {
                if let index = Int(hash[hash.index(hash.startIndex, offsetBy: 5)...hash.index(hash.startIndex, offsetBy: 5)]), index < codeLength, code[index] == nil {
                    let character = hash[hash.index(hash.startIndex, offsetBy: 6)...hash.index(hash.startIndex, offsetBy: 6)]
                    code[index] = character

                    let readableCode = code.map { $0 ?? "-" }.joined()
                    print("Code is now \(readableCode)")
                }
            }

            if !code.contains(where: { $0 == nil }) {
                break
            }

            index += 1
        }

        return code.flatMap { $0 }.joined()
    }
    
    private func MD5String(string: String) -> String {
        return MD5(string: string)!.map { String(format: "%02hhx", $0) }.joined()
    }
    
    private func MD5(string: String) -> Data? {
        guard let messageData = string.data(using:String.Encoding.utf8) else { return nil }
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
}
