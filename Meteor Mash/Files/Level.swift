//
//  Level.swift
//  Meteor Mash
//
//  Created by Josh Madison on 4/18/23.
//

import SpriteKit
import GameplayKit

class Level: SKScene, SKPhysicsContactDelegate {
    
    var turret = SKSpriteNode()
    var backButton = SKSpriteNode()
    var shootButton = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var livesLabel = SKLabelNode()
    var points = 0
    var playingLevel = false
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        createBackground()
        createButtons()
        createLabels()
        createEnemies()
        createHazards()
        createTurret()
    }
    
    func createBackground() {
        let space = SKTexture(imageNamed: "MeteorMashBackground")
        for i in 0...1 {
            let spaceBackground = SKSpriteNode(texture: space)
            spaceBackground.zPosition = -3
            spaceBackground.position = CGPoint(x: 0, y: spaceBackground.size.height * CGFloat(i))
            addChild((spaceBackground))
            let moveDown = SKAction.moveBy(x: 0, y: -spaceBackground.size.height, duration: 4)
            let moveReset = SKAction.moveBy(x: 0, y: spaceBackground.size.height, duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            spaceBackground.run(moveForever)
        }
    }
    
    func createButtons() {
        let BackButton = SKTexture(imageNamed: "BackButton")
        backButton = SKSpriteNode(texture: BackButton, size: CGSize(width: 40, height: 40))
        backButton.position = CGPoint(x: frame.midX - 350, y: frame.midY + 150)
        backButton.name = "backButton"
        backButton.zPosition = -2
        backButton.alpha = 0.5
        addChild(backButton)
        
        let FireButton = SKTexture(imageNamed: "FireButton")
        shootButton = SKSpriteNode(texture: FireButton, size: CGSize(width: 100, height: 100))
        shootButton.position = CGPoint(x: frame.midX + 340, y: frame.midY - 115)
        shootButton.zPosition = -2
        shootButton.alpha = 0.5
        addChild(shootButton)
    }
    
    func createLabels() {
        
    }
    
    func createTurret() {
        let character = SKTexture(imageNamed: "Turret")
        turret = SKSpriteNode(texture: character, size: CGSize(width: 50, height: 50))
        turret.position = CGPoint(x: frame.midX, y: frame.midY - 130)
        turret.zPosition = -1
        addChild(turret)
    }
    
    func createEnemies() {
        let enemy = SKTexture(imageNamed: "Alien")
        let alien = SKSpriteNode(texture: enemy)
        
    }
    
    func createHazards() {
        let hazard = SKTexture(imageNamed: "Meteor")
        let meteor = SKSpriteNode(texture: hazard)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "backButton" {
                    let scene = Intro(fileNamed: "Intro")
                    let transition = SKTransition.moveIn(with: .right, duration: 3)
                    self.view?.presentScene(scene!, transition: transition)
                }
            }
        }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if playingLevel {
                turret.position.x = location.x
            }
        }
    }
    
    
}
