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
    var aliens = [SKSpriteNode]()
    var alien = SKSpriteNode()
    var meteor = SKSpriteNode()
    var laser = SKSpriteNode()
    var backButton = SKSpriteNode()
    var shootButton = SKSpriteNode()
    var leftButton = SKSpriteNode()
    var rightButton = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var livesLabel = SKLabelNode()
    var points = 0
    var isTouching = false
    var moving = false
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
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
            let moveDown = SKAction.moveBy(x: 0, y: -spaceBackground.size.height, duration: 3)
            let moveReset = SKAction.moveBy(x: 0, y: spaceBackground.size.height, duration: 0)
            let moveLoop = SKAction.sequence([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            spaceBackground.run(moveForever)
        }
    }
    
    func createButtons() {
        let BackButton = SKTexture(imageNamed: "BackButton")
        backButton = SKSpriteNode(texture: BackButton, size: CGSize(width: 60, height: 40))
        backButton.position = CGPoint(x: frame.midX - 350, y: frame.midY + 150)
        backButton.name = "backButton"
        backButton.zPosition = -2
        backButton.alpha = 0.2
        addChild(backButton)
        
        let FireButton = SKTexture(imageNamed: "FireButton")
        shootButton = SKSpriteNode(texture: FireButton, size: CGSize(width: 100, height: 100))
        shootButton.position = CGPoint(x: frame.midX + 340, y: frame.midY - 115)
        shootButton.name = "fireButton"
        shootButton.zPosition = -2
        shootButton.alpha = 0.2
        addChild(shootButton)
        
        let LeftButton = SKTexture(imageNamed: "LeftButton")
        leftButton = SKSpriteNode(texture: LeftButton, size: CGSize(width: 90, height: 80))
        leftButton.position = CGPoint(x: frame.midX - 340, y: frame.midY - 130)
        leftButton.name = "LeftButton"
        leftButton.zPosition = -2
        leftButton.alpha = 0.2
        addChild(leftButton)
        
        let RightButton = SKTexture(imageNamed: "RightButton")
        rightButton = SKSpriteNode(texture: RightButton, size: CGSize(width: 90, height: 80))
        rightButton.position = CGPoint(x: frame.midX - 200, y: frame.midY - 130)
        rightButton.name = "RightButton"
        rightButton.zPosition = -2
        rightButton.alpha = 0.2
        addChild(rightButton)
    }
    
    func createLabels() {
        
    }
    
    func createTurret() {
        turret.removeFromParent()
        let character = SKTexture(imageNamed: "Turret")
        turret = SKSpriteNode(texture: character, size: CGSize(width: 50, height: 50))
        turret.position = CGPoint(x: frame.midX, y: frame.midY - 110)
        turret.zPosition = -3
        turret.physicsBody = SKPhysicsBody(rectangleOf: turret.size)
        turret.physicsBody? .isDynamic = false
        func walk(force: CGFloat) {
            self.physicsBody?.applyForce(CGVector(dx: force, dy: 0.0))
        }
        addChild(turret)
    }
    
    func createEnemies() {
        let enemy = SKTexture(imageNamed: "Alien")
        alien = SKSpriteNode(texture: enemy, size: CGSize(width: 50, height: 50))
        addChild(alien)
        aliens.append(alien)
    }
    
    func createHazards() {
        let hazard = SKTexture(imageNamed: "Meteor")
        meteor = SKSpriteNode(texture: hazard, size: CGSize(width: 40, height: 70))
        let moveDown = SKAction.moveBy(x: 0, y: -hazard.size().height, duration: 3)
        let moveReset = SKAction.moveBy(x: 0, y: hazard.size().height, duration: 0)
        let moveLoop = SKAction.sequence([moveDown, moveReset])
        let moveDownScreen = SKAction.repeatForever(moveLoop)
        meteor.run(moveDownScreen)
        addChild(meteor)
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
            if touchedNode.name == "LeftButton" {
                moving = true
                isTouching = true
                turret.position.x = turret.position.x - 50
            }
            if touchedNode.name == "RightButton" {
                moving = true
                isTouching = true
                turret.position.x = turret.position.x + 50
            }
            if touchedNode.name == "FireButton" {
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)
            if touchedNode.name == "LeftButton"  {
                moving = false
                isTouching = false
            }
            if touchedNode.name == "RightButton" {
                moving = false
                isTouching = false
            }
        }
    }
    override func update(_ currentTime: CFTimeInterval) {
        if isTouching && moving {
            
        }
    }
}
