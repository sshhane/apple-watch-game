//
//  MenuScene.swift
//  spaceGame
//
//  Created by Shane Daniels on 27/03/2019.
//  Copyright © 2019 Shane Daniels. All rights reserved.
//
import SpriteKit

class MenuScene: SKScene {
    
    var starfield:SKEmitterNode!
    
    var newGameButtonNode:SKSpriteNode!
    
    override func didMove(to view: SKView) {
        starfield = (self.childNode(withName: "starfield") as! SKEmitterNode)
        starfield.advanceSimulationTime(10)
        
        newGameButtonNode = (self.childNode(withName: "newGameButton") as! SKSpriteNode)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let locattion = touch?.location(in: self) {
            let nodesArray = self.nodes(at: locattion)
            
            if nodesArray.first?.name == "newGameButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
            }
        }
    }
}
