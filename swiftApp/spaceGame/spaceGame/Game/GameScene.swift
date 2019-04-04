//
//  GameScene.swift
//  spaceGame
//
//  Created by Shane Daniels on 19/02/2019.
//  Copyright © 2019 Shane Daniels. All rights reserved.
//

// imoort CorreMotion
import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var i = 0
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
    let laserType:UInt32 = 0x1 << 0
    
    // motion tracking
    let motionManager = CMMotionManager()
    var xAccel:CGFloat = 0
    
    // WatchSession
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // watch direction
    var direction = 0
    var timer = Timer()

    override func didMove(to view: SKView) {
        
        // timer
        scheduledTimerWithTimeInterval()

        
        // starfield background
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        starfield.zPosition = -1
        
        // player
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 20, y: -550)
        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        // score label
        scoreLabel = SKLabelNode(text: "Points: 0")
        scoreLabel.position = CGPoint(x: 300, y: 600)
        self.addChild(scoreLabel)

        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAsteroid), userInfo: nil, repeats: true)
        
        // motion tracking for phone
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data:CMAccelerometerData?, error:Error?) in
            if let accelerometerData = data {
                let acceleration = accelerometerData.acceleration
                // increase acceleration
                self.xAccel = CGFloat(acceleration.x) * 0.75 + self.xAccel * 0.25
            }
        }
        
        // motion tracking for watch
        // increase acceleration
        self.xAccel = CGFloat(getDir()) * 0.75 + self.xAccel * 0.25
        
        print(getDir())
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
    
    func fire() {
        let laser = SKSpriteNode(imageNamed: "laserGreen")
        laser.position = player.position
        laser.position.y += 3
        
        laser.physicsBody = SKPhysicsBody(circleOfRadius: laser.size.width)
        laser.physicsBody?.isDynamic = true
        
        laser.physicsBody?.categoryBitMask = laserType
        laser.physicsBody?.contactTestBitMask = enemyType
        laser.physicsBody?.collisionBitMask = 0
        laser.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(laser)
        
        let animationDuration:TimeInterval = 0.3
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: self.frame.size.height + 10), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        laser.run(SKAction.sequence(actionArray))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        fire()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var first:SKPhysicsBody
        var second: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            first = contact.bodyA
            second = contact.bodyB
        } else {
            first = contact.bodyB
            second = contact.bodyA
        }
        
        // comparing the bits to find which body is laser
        if (first.categoryBitMask & laserType) != 0 && (second.categoryBitMask & enemyType) != 0 {
            // first is laser
            laserHit(laser: first.node as! SKSpriteNode, enemy: second.node as! SKSpriteNode)
        }
    }
    
    func laserHit(laser:SKSpriteNode, enemy:SKSpriteNode) {
        let fireBall = SKEmitterNode(fileNamed: "Explosion")!
        
        // run explosion
        fireBall.position = enemy.position
        self.addChild(fireBall)
        
        // remove from scene
        laser.removeFromParent()
        enemy.removeFromParent()
        
        // increment the score
        score += 10
    }
    
    override func didSimulatePhysics() {
        let num:CGFloat = CGFloat(getDir())
        // update player location
        player.position.x += num * 20
        
        // keep player on screen
        if player.position.x < -310 {
            player.position = CGPoint(x: -309, y: player.position.y)
        }else if player.position.x > 310 {
            player.position = CGPoint(x: 309, y: player.position.y)
        }
    }
    
    func scheduledTimerWithTimeInterval(){
    // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
    timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateCounting() {
        NSLog("counting..")
    }
    
    func getDir() -> Int {
        if appDelegate.dir == "left" {
            print("left: \(appDelegate.dir)")
            return -1
        } else if appDelegate.dir == "right" {
            return  1
        } else {
            return  0
        }
        return 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
