//
//  FateGenerator.swift
//  Prophecy
//
//  Created by Serhii.Lomov on 12.04.2021.
//

import Foundation

final class FateGenerator {
    private enum Activator: String, CaseIterable {
        case devil
        case alien
        case clown
        case robot
        case death
        case ghost
        case cat
        case dog
        case money
        case detective
    }
    
    private enum Action: String, CaseIterable {
        case kiss
        case love
        case see
        case sleep
        case punch
        case hear
        case write
        case leak
        case burn
        case freez
    }
    
    private enum Target: String, CaseIterable {
        case mind
        case blood
        case tooth
        case family
        case cat
        case dog
        case ambulance
    }
    
    private enum Condition: String, CaseIterable {
        case sleep
        case clock1
        case clock2
        case clock3
        case clock4
        case moon1
        case moon2
        case moon3
        case moon4
        case weather1
        case weather2
        case weather3
        case weather4
    }
    
    private enum Confusing: String, CaseIterable {
        case camera
        case scissros
        case miscroscope
        case radiation
        case biohazard
        case ortodox
        case latin
        case menorach
        case sixStart
        case islam
    }
    
    // Remote change 6
    
    public func additionalFate(name: String) -> String {
        var magicNumber = 3
        name.forEach { magicNumber += Int($0.asciiValue ?? 1) }
        return longFate(seed: magicNumber)
    }
    
    /**
     One fate for one soul at all times
     */
    public func fate(name: String) -> String {
        var magicNumber = 1
        name.forEach { magicNumber += Int($0.asciiValue ?? 1) }
        return longFate(seed: magicNumber)
    }
    
    private func longFate(seed: Int) -> String {
        let firstFate = fate(seed: seed * 2)
        let secondFate = fate(seed: seed * 3)
        return firstFate + "\n" + secondFate
    }
    
    private func fate(seed: Int) -> String {
        var tempSeed = seed
        var words = [String]()
        words.append(readFromSeed(values: Condition.allCases,
                                  seed: &tempSeed).rawValue)
        words.append(readFromSeed(values: Activator.allCases,
                                  seed: &tempSeed).rawValue)
        words.append(readFromSeed(values: Action.allCases,
                                  seed: &tempSeed).rawValue)
        words.append(readFromSeed(values: Target.allCases,
                                  seed: &tempSeed).rawValue)
        
        let confusing1 = readFromSeed(values: Confusing.allCases,
                                      seed: &tempSeed).rawValue
        let confusing2 = readFromSeed(values: Confusing.allCases,
                                      seed: &tempSeed).rawValue
        
        let confusingIndex1 = seed % words.count
        let confusingIndex2 = (seed / words.count) % words.count
        
        words.insert(confusing1, at: confusingIndex1)
        words.insert(confusing2, at: confusingIndex2)
        
        return words.joined(separator: " ")
    }
    
    private func readFromSeed<T> (values: [T], seed: inout Int) -> T {
        let index = seed % values.count
        seed = seed / 2
        return values[index]
    }
}
