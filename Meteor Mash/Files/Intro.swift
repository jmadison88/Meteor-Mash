//
//  GameScene.swift
//  Meteor Mash
//
//  Created by Josh Madison on 4/13/23.
//

import SpriteKit
import GameplayKit

class Intro: SKScene {
    
    var titleLabel = SKLabelNode()
    var startButton = SKSpriteNode()
    var scoreButton = SKSpriteNode()
    var startText = SKLabelNode()
    var scoreText = SKLabelNode()
    
    override func didMove(to view: SKView) {
        createBackground()
        createLabels()
        createButtons()
        playMusic()
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
    
    func createButtons() {
        startButton = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 50))
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
        startButton.name = "startButton"
        startButton.zPosition = -2
        addChild(startButton)
        
        scoreButton = SKSpriteNode(color: .white, size: CGSize(width: 200, height: 50))
        scoreButton.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        scoreButton.name = "scoreButton"
        scoreButton.zPosition = -2
        addChild(scoreButton)
        
    }
    
    func createLabels() {
        titleLabel.text = "Meteor Mash"
        titleLabel.fontName = "Arial"
        titleLabel.fontSize = 100
        titleLabel.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(titleLabel)
        
        startText.text = "Play!"
        startText.fontName = "Arial"
        startText.fontSize = 45
        startText.position = CGPoint(x: frame.midX, y: frame.midY - 15)
        startText.zPosition = -1
        startText.name = "startButton"
        startText.fontColor = UIColor.black
        addChild(startText)
        
        scoreText.text = "Scores"
        scoreText.fontName = "Arial"
        scoreText.fontSize = 45
        scoreText.position = CGPoint(x: frame.midX, y: frame.midY - 115)
        scoreText.zPosition = -1
        scoreText.name = "scoreButton"
        scoreText.fontColor = UIColor.black
        addChild(scoreText)
    }
    
    func playMusic() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "startButton" {
                let scene = Level(fileNamed: "Level")
                let transition = SKTransition.moveIn(with: .right, duration: 3)
                self.view?.presentScene(scene!, transition: transition)
            }
            if touchedNode.name == "scoreButton" {
                let scene2 = Scores(fileNamed: "Scores")!
                let transition2 = SKTransition.moveIn(with: .right, duration: 1)
                self.view?.presentScene(scene2, transition: transition2)
            }
        }
    }
}