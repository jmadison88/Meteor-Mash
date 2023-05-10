//
//  Level.swift
//  Meteor Mash
//
//  Created by Josh Madison on 4/18/23.
//

import SpriteKit
import GameplayKit

class Level: SKScene, SKPhysicsContactDelegate {
    
    struct PhysicsCategory {
        static let none: UInt32 = 0
        static let meteor: UInt32 = 0b1
        static let laser: UInt32 = 0b10
        static let turret: UInt32 = 0b10
    }
    
    var turret = SKSpriteNode()
    var laser = SKSpriteNode()
    var aliens = [SKSpriteNode]()
    var alien = SKSpriteNode()
    var alien2 = SKSpriteNode()
    var alien3 = SKSpriteNode()
    var meteor = SKSpriteNode()
    var backButton = SKSpriteNode()
    var shootButton = SKSpriteNode()
    var leftButton = SKSpriteNode()
    var rightButton = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var livesLabel = SKLabelNode()
    var isTouching = false
    var moving = false
    var isPlaying = false
    var counterTimer = Timer()
    var counter = 0
    var counterStartValue = 180
    var counterLabel = SKLabelNode()
    var lives = 3
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        createBackground()
        createButtons()
        createLabels()
        createEnemies()
        createTurret()
        startTimer()
        decrementCounter()
        
        run(SKAction.repeatForever(
            SKAction.sequence([SKAction.run(choosePositionMeteor),
                SKAction.run(createHazards),
                SKAction.wait(forDuration: 3.0)
                ])
            ))
        run(SKAction.repeatForever(
            SKAction.sequence([SKAction.run(choosePositionEnemies),
                SKAction.run(createEnemies),
                SKAction.wait(forDuration: 3.0)
                ])
            ))
    }
    
    func winResults() {
        let scene = WinningScreen(fileNamed: "Winning Screen")
        let transition = SKTransition.moveIn(with: .right, duration: 2)
        self.view?.presentScene(scene!, transition: transition)
    }
    
    func backToIntro() {
        let scene = Intro(fileNamed: "Intro")
        let transition = SKTransition.moveIn(with: .right, duration: 2)
        self.view?.presentScene(scene!, transition: transition)
    }
    
    func startTimer() {
        counterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc func decrementCounter() {
        counterLabel.text = "Time: \(counter)"
        counter -= 1
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
        counterLabel.text = "Time: \(counter)"
        livesLabel.text = "Lives: \(lives)"
    }
    
    func createLabels() {
        livesLabel.fontSize = 30
        livesLabel.fontColor = .white
        livesLabel.position = CGPoint(x: frame.midX + 350, y: frame.midY + 150)
        addChild(livesLabel)
        
        scoreLabel.fontSize = 30
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: frame.midX + 350, y: frame.midY + 125)
        addChild(scoreLabel)
        
        counterLabel.fontSize = 30
        counterLabel.fontColor = .white
        counterLabel.position = CGPoint(x: frame.midX - 250, y: frame.midY + 150)
        counter = counterStartValue
        addChild(counterLabel)
        
    }
    
    func createLaser() {
        let greenLaser = SKTexture(imageNamed: "Laser")
        laser = SKSpriteNode(texture: greenLaser, size: CGSize(width: 10, height: 50))
        laser.physicsBody?.contactTestBitMask = laser.physicsBody!.collisionBitMask
        laser.physicsBody?.restitution = 1
        laser.position = turret.position
        laser.physicsBody?.usesPreciseCollisionDetection = true
        laser.zPosition = -3
        laser.name = "laser"
        let moveUp = SKAction.moveBy(x: 0, y: +greenLaser.size().height, duration: 3)
        let moveReset = SKAction.moveBy(x: 0, y: greenLaser.size().height, duration: 0)
        let moveLoop = SKAction.sequence([moveUp, moveReset])
        let moveUpScreen = SKAction.repeatForever(moveLoop)
        laser.run(moveUpScreen)
        laser.physicsBody = SKPhysicsBody(rectangleOf: laser.size)
        laser.physicsBody?.isDynamic = false
        addChild(laser)
    }
    
    func createTurret() {
        let character = SKTexture(imageNamed: "Turret")
        turret = SKSpriteNode(texture: character, size: CGSize(width: 50, height: 50))
        turret.position = CGPoint(x: frame.midX, y: frame.midY - 110)
        turret.zPosition = -3
        turret.name = "turret"
        turret.physicsBody = SKPhysicsBody(rectangleOf: turret.size)
        turret.physicsBody? .isDynamic = false
        addChild(turret)
    }
    
    func createEnemies() {
        let enemy = SKTexture(imageNamed: "Alien")
        alien = SKSpriteNode(texture: enemy, size: CGSize(width: 50, height: 50))
        alien.name = "alien"
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: -100, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 0))
        let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        let moveForever = SKAction.repeatForever(move)
        alien.run(moveForever)
        let enemy2 = SKTexture(imageNamed: "Alien")
        alien2 = SKSpriteNode(texture: enemy2, size: CGSize(width: 50, height: 50))
        alien2.name = "alien"
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: 0, y: 0))
        path2.addLine(to: CGPoint(x: -100, y: 0))
        path2.addLine(to: CGPoint(x: 100, y: 0))
        let move2 = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        let moveForever2 = SKAction.repeatForever(move2)
        alien2.run(moveForever2)
        let enemy3 = SKTexture(imageNamed: "Alien")
        alien3 = SKSpriteNode(texture: enemy3, size: CGSize(width: 50, height: 50))
        alien3.name = "alien"
        let path3 = UIBezierPath()
        path3.move(to: CGPoint(x: 0, y: 0))
        path3.addLine(to: CGPoint(x: -100, y: 0))
        path3.addLine(to: CGPoint(x: 100, y: 0))
        let move3 = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
        let moveForever3 = SKAction.repeatForever(move3)
        alien3.run(moveForever3)
    }
    
    func choosePositionMeteor() {
        let height = UInt32(self.size.height)
        let width = UInt32(self.size.width)
        let randomPostion = CGPoint(x: Int(arc4random_uniform(width)), y: Int(arc4random_uniform(height)))
        addChild(meteor)
        meteor.position = randomPostion
    }
    func choosePositionEnemies() {
        let int1 = Int.random(in: 0...10)
        if int1 > 7 {
            alien.position = CGPoint(x: frame.midX - 100, y: frame.midY + 150 )
            alien2.position = CGPoint(x: frame.midX , y: frame.midY - 160)
            alien3.position = CGPoint(x: frame.midX + 90, y: frame.midY + 120)
            
            
        }
        else if int1 > 4 {
            alien.position = CGPoint(x: frame.midX - 130, y: frame.midY + 150)
            alien2.position = CGPoint( x: frame.midX + 100, y: frame.midY + 150)
            alien3.position = CGPoint(x: frame.midX  + 95, y: frame.midY + 100)
        } else {
            
        }
        addChild(alien)
        addChild(alien2)
        addChild(alien3)
    }

    func createHazards() {
        let hazard = SKTexture(imageNamed: "Meteor")
        meteor = SKSpriteNode(texture: hazard, size: CGSize(width: 40, height: 70))
        meteor.name = "meteor"
        meteor.physicsBody = SKPhysicsBody(rectangleOf: meteor.size)
        meteor.physicsBody?.isDynamic = true
        meteor.physicsBody?.categoryBitMask = PhysicsCategory.meteor
        meteor.physicsBody?.contactTestBitMask = PhysicsCategory.laser
        meteor.physicsBody?.contactTestBitMask = PhysicsCategory.turret
        meteor.physicsBody?.collisionBitMask = PhysicsCategory.none
        meteor.zPosition = -3
        let moveDown = SKAction.moveBy(x: 0, y: -hazard.size().height, duration: 4)
        let moveReset = SKAction.removeFromParent()
        meteor.run(SKAction.sequence([moveDown, moveReset]))
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
        laser.physicsBody = SKPhysicsBody(circleOfRadius: laser.size.width/2)
        laser.physicsBody?.isDynamic = true
        laser.physicsBody?.categoryBitMask = PhysicsCategory.laser
        laser.physicsBody?.contactTestBitMask = PhysicsCategory.meteor
        laser.physicsBody?.collisionBitMask = PhysicsCategory.none
        laser.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
          } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
          }
        if ((firstBody.categoryBitMask & PhysicsCategory.meteor != 0) &&
              (secondBody.categoryBitMask & PhysicsCategory.laser != 0)) {
            if let meteor = firstBody.node as? SKSpriteNode,
              let laser = secondBody.node as? SKSpriteNode {
              laserCollision(laser: laser, meteor: meteor)
            }
          }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        updateLabels()
        if counter == 0 {
            winResults()
        }
        if ((turret.parent) != nil) {
            
        } else {
            backToIntro()
        }
    }
    
    func laserCollision(laser: SKSpriteNode, meteor: SKSpriteNode) {
        print("Contact!")
        laser.removeFromParent()
        meteor.removeFromParent()
    }
}
