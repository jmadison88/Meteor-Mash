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
    var laser = SKSpriteNode()
    var aliens = [SKSpriteNode]()
    var alien = SKSpriteNode()
    var meteor = SKSpriteNode()
    var backButton = SKSpriteNode()
    var shootButton = SKSpriteNode()
    var leftButton = SKSpriteNode()
    var rightButton = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var livesLabel = SKLabelNode()
    var points = 0
    var Lives = SKSpriteNode()
    var lives = 3
    var isTouching = false
    var moving = false
    var isPlaying = false
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        createBackground()
        createButtons()
        createLabels()
        createEnemies()
        createHazards()
        createTurret()
       makeLives()
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
        shootButton.name = "FireButton"
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
    func updateLabels() {
        livesLabel.text = "Lives: \(lives)"
    }
    func createLabels() {
        livesLabel.fontSize = 18
        livesLabel.fontColor = .white
        livesLabel.position = CGPoint(x: frame.minX + 50, y: frame.minY + 18 )
        addChild(livesLabel)
    }
    
    func createLaser() {
        let greenLaser = SKTexture(imageNamed: "Laser")
        laser = SKSpriteNode(texture: greenLaser, size: CGSize(width: 10, height: 50))
        laser.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        laser.physicsBody?.isDynamic = false
        laser.physicsBody?.usesPreciseCollisionDetection = true
        turret.position = CGPoint(x: frame.midX, y: frame.midY - 100)
        laser.zPosition = -3
        addChild(laser)
    }
    
    func createTurret() {
        turret.removeFromParent()
        let character = SKTexture(imageNamed: "Turret")
        turret = SKSpriteNode(texture: character, size: CGSize(width: 50, height: 50))
        turret.position = CGPoint(x: frame.midX, y: frame.midY - 110)
        turret.zPosition = -3
        turret.physicsBody = SKPhysicsBody(rectangleOf: turret.size)
        turret.physicsBody? .isDynamic = false
        addChild(turret)
    }
    func makeLives() {
            let heart =  SKTexture(imageNamed: "Lives")
            Lives = SKSpriteNode(texture: heart, size: CGSize(width: 50, height: 50))
            //Lives.setScale(0.5)
        Lives.position = CGPoint(x:frame.midX, y : frame.midY)
            Lives.zPosition = -3
            
           
            addChild(Lives)
              }
    
    func createEnemies() {
        let enemy = SKTexture(imageNamed: "Alien")
        alien = SKSpriteNode(texture: enemy, size: CGSize(width: 50, height: 50))
        addChild(alien)
        aliens.append(alien)
        
    }
     
    func choosePosition() {
        let pick = arc4random_uniform(10) + 1
        if pick > 7 {
            meteor.position = CGPoint(x: frame.midX - 250, y: frame.maxY)
        }
        else if pick > 4 {
            meteor.position = CGPoint(x: frame.midX, y: frame.maxY)
        }
        else {
            meteor.position = CGPoint(x: frame.midX + 250, y: frame.maxY)
        }
    }
    
    func updateHazard()
    {
        isPlaying = true
        if isPlaying == true {
            choosePosition()
        }
        
    }
    
        
        
        func createHazards() {
            let hazard = SKTexture(imageNamed: "Meteor")
            meteor = SKSpriteNode(texture: hazard, size: CGSize(width: 40, height: 70))
            meteor.position = CGPoint(x: frame.midX, y: frame.maxY)
            let moveDown = SKAction.moveBy(x: 0, y: -hazard.size().height, duration: 5)
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
                    createLaser()
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
        }
    }

