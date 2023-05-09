//
//  Winning Screen.swift
//  Meteor Mash
//
//  Created by Josh Madison on 5/8/23.
//

import SpriteKit
import GameplayKit

class WinningScreen: SKScene {
    
    var resultsLabel = SKLabelNode()
    
    func createBackground() {
        let space = SKTexture(imageNamed: "MeteorMashBackground")
        for i in 0...1 {
            let spaceBackground = SKSpriteNode(texture: space)
            spaceBackground.zPosition = -3
            spaceBackground.position = CGPoint(x: 0, y: spaceBackground.size.height * CGFloat(i))
            addChild((spaceBackground))
            let moveDown = SKAction.moveBy(x: 0, y: -spaceBackground.size.height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: spaceBackground.size.height, duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            spaceBackground.run(moveForever)
        }
    }
    
    func createLabels() {
        resultsLabel.text = "Congratulations! You fended off the alien invasion!"
        resultsLabel.fontName = "Arial"
        resultsLabel.fontSize = 100
        resultsLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(resultsLabel)
        
        
    }
    
    func playMusic() {
        
    }
}
