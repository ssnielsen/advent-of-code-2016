//
//  Day 11.swift
//  AdventOfCode2016
//
//  Created by Soren Sonderby Nielsen on 26/11/2017.
//  Copyright © 2017 sonderby Inc. All rights reserved.
//

import Foundation

struct Day11 {
    enum Element: String {
        case thulium
        case promethium
        case ruthenium
        case cobalt
        case polonium
    }
    
    enum Device: String {
        case generator
        case microchip
    }
    
    struct Part: CustomStringConvertible {
        let element: Element
        let device: Device
        
        var description: String {
            return "\(element) \(device)"
        }
    }
    
    struct Floor {
        var parts: [Part]
    }
    
    struct Building {
        var floors: [Floor]
        var elevatorLocation: Int
    }
    
    let minimumElevatorCapacity = 1
    let maximumElevatorCapacity = 2
    
    static let PoG = Part(element: .polonium, device: .generator)
    static let PoM = Part(element: .polonium, device: .microchip)
    static let PrG = Part(element: .promethium, device: .generator)
    static let PrM = Part(element: .promethium, device: .microchip)
    static let ThG = Part(element: .thulium, device: .generator)
    static let ThM = Part(element: .thulium, device: .microchip)
    static let RuG = Part(element: .ruthenium, device: .generator)
    static let RuM = Part(element: .ruthenium, device: .microchip)
    static let CoG = Part(element: .cobalt, device: .generator)
    static let CoM = Part(element: .cobalt, device: .microchip)
    
    static let initialFloors = [
        Floor(parts: [PoG, ThG, ThM, PrG, RuG, RuM, CoG, CoG]),
        Floor(parts: [PoM, PrM]),
        Floor(parts: []),
        Floor(parts: [])
    ]
    
    let building = Building(floors: initialFloors, elevatorLocation: 0)
    

}











