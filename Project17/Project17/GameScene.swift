//
//  GameScene.swift
//  Project17
//
//  Created by Volodymyr Ostapyshyn on 03.07.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    var isTracking = false
    let possibleEnemies = ["ball", "hammer", "tv"]
    var isGameOver = false
    var enemyCounter = 0
    var timeInterval: TimeInterval = 0.35
    var gameTimer: Timer?
    
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)

        player.removeFromParent()

        isGameOver = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {

        guard let touch = touches.first else { return }
        let location = touch.location(in: self)

        let nodes = Set(self.nodes(at: location))
        // Only start tracking if the touch is in the spaceship
        if nodes.contains(player) { isTracking = true }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    @objc func createEnemy() {
        guard let enemy = possibleEnemies.randomElement() else { return }

        let sprite = SKSpriteNode(imageNamed: enemy)
        sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
        addChild(sprite)

        sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
        sprite.physicsBody?.categoryBitMask = 1
        sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
        sprite.physicsBody?.angularVelocity = 5
        sprite.physicsBody?.linearDamping = 0
        sprite.physicsBody?.angularDamping = 0
        
        enemyCounter += 1

        if enemyCounter >= 20 {
            enemyCounter = 0
            timeInterval -= 0.01
            gameTimer?.invalidate()
            gameTimer = Timer.scheduledTimer(timeInterval: timeInterval,
                                             target: self,
                                             selector: #selector(createEnemy),
                                             userInfo: nil, repeats: true)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isTracking else { return }
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)

        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }

        player.position = location
        
        guard isTracking else { return }

        
    }
    
    func endGame() {
        isGameOver = true
        gameTimer?.invalidate()
        let moveAction = SKAction.move(to: CGPoint(x: 512, y: 360), duration: 0.6)
        let scaleAction = SKAction.scale(to: 3, duration: 0.6)
        let groupAction = SKAction.group([moveAction, scaleAction])
        scoreLabel.run(groupAction)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }

        if !isGameOver {
            score += 1
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        isTracking = false
    }
    
    
}
