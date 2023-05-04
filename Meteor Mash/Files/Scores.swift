//
//  Scores.swift
//  Meteor Mash
//
//  Created by Josh Madison on 4/18/23.
//

import SpriteKit
import GameKit

let score = "score"
let bestScore = "bestScore"
class Scores: SKScene {
    func setScore(value: Int) {
        if value > getBestScore() {
            setBestScore(value: value)
        }
        UserDefaults.standard.set(value, forKey: score)
        UserDefaults.standard.synchronize()
    }
    
    func getScore() -> Int {
        return UserDefaults.standard.integer(forKey: score)
        
    }
    func setBestScore(value: Int) {
        UserDefaults.standard.set(value, forKey: bestScore)
        UserDefaults.standard.synchronize()
    }
    
    func getBestScore() -> Int {
        return UserDefaults.standard.integer(forKey: bestScore)
        
    }
}
