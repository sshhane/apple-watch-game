//
//  MenuScene.swift
//  spaceGame
//
//  Created by Shane Daniels on 27/03/2019.
//  Copyright © 2019 Shane Daniels. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    var starfield:SKEmitterNode!
    
    var newGameButtonNode:SKSpriteNode!
    
    override func didMove(to view: SKView) {
        starfield = self.childNode(withName: "starfield") as! SKEmitterNode
        starfield.advanceSimulationTime(10)
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
        
        
    }

}
