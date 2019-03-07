//
//  GameScene.swift
//  spaceGame
//
//  Created by Shane Daniels on 19/02/2019.
//  Copyright © 2019 Shane Daniels. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield:SKEmitterNode!
    var player:SKSpriteNode!
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Points: \(score)"
        }
    }
    
    var gameTimer:Timer!
    
    var enemies = ["meteorBrown_tiny1", "enemyBlue3"]
    
    // bitmasks
    let enemyType:UInt32 = 0x1 << 1
    
    override func didMove(to view: SKView) {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        

        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")

        player.position = CGPoint(x: 20, y: -550)
        
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self

        scoreLabel = SKLabelNode(text: "Points: 0")
        scoreLabel.position = CGPoint(x: 300, y: 600)
        self.addChild(scoreLabel)

        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAsteroid), userInfo: nil, repeats: true)
    }
    
    @objc func addAsteroid() {
        // get random enemy
        enemies = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: enemies) as! [String]
        let enemy = SKSpriteNode(imageNamed: enemies[0])

        // get a random position for enamy to spawn
        let randomPos = GKRandomDistribution(lowestValue: -300, highestValue: 300)
        let position = CGFloat(randomPos.nextInt())

        // set the position plus a bit to get off screen
        enemy.position = CGPoint(x: position, y: self.frame.size.height + enemy.size.height)

        // allow physics and collisions for enemy
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
        enemy.physicsBody?.isDynamic = true

        enemy.physicsBody?.categoryBitMask = enemyType

        self.addChild(enemy)

        var actionArray = [SKAction]()

        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -999), duration: 6))
        actionArray.append(SKAction.sequence(actionArray))

        enemy.run(SKAction.sequence(actionArray))
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
