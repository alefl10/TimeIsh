//
//  GameScene.swift
//  TimeIsh
//
//  Created by Alejandro Ferrero on 11/14/17.
//  Copyright © 2017 Alejandro Ferrero. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        clockScene()
    }
    
    override func sceneDidLoad() {
        let backgroundNode = childNode(withName: "backgroundNode")
        let logoNode = childNode(withName: "logoNode")
        
        if (backgroundNode != nil) && (logoNode != nil) {
            backgroundNode?.zPosition = 0
            logoNode?.zPosition = 1
        }
    }
    
    private func clockScene() {
        let sequence = SKAction.sequence([
            SKAction.wait(forDuration: 2.0),
            SKAction.run( {
                    let fadeAway = SKTransition.fade(withDuration: 1.5)
                    let clockScene = ClockScene(fileNamed: "ClockScene")
                    self.view?.presentScene(clockScene!, transition: fadeAway)
                })
            ])
        self.run(sequence)
    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
