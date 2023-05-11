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
    var pointLabel = SKLabelNode()
    var backButton = SKSpriteNode()
    var points = 0
    
    override func didMove(to view: SKView) {
        createLabels()
        createBackground()
    }
    
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
        resultsLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(resultsLabel)
        
        pointLabel.text = "Total Score: \(points)"
        pointLabel.fontName = "Arial"
        pointLabel.fontSize = 50
        pointLabel.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        addChild(pointLabel)
        
    }
    
    func createButtons() {
        backButton = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 50))
        backButton.position = CGPoint(x: frame.midX, y: frame.midY - 200)
        backButton.name = "backButton"
        backButton.zPosition = -2
        addChild(backButton)
    }
    
    func backToIntro() {
        let scene = Intro(fileNamed: "Intro")
        let transition = SKTransition.moveIn(with: .right, duration: 2)
        self.view?.presentScene(scene!, transition: transition)
    }
    
    func playMusic() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "backButton" {
                let scene = Intro(fileNamed: "Intro")
                let transition = SKTransition.moveIn(with: .right, duration: 2)
                self.view?.presentScene(scene!, transition: transition)
            }
        }
    }
}
