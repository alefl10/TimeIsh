//
//  ClockNode.swift
//  TimeIsh
//
//  Created by Alejandro Ferrero on 11/14/17.
//  Copyright © 2017 Alejandro Ferrero. All rights reserved.
//

import Foundation
import SpriteKit

class ClockNode {
    
    
    private var _clockScene = SKScene()
    private var _clockNode: SKSpriteNode!
    
    private final let CLOCK_WIDTH = CGFloat(412.0)
    private final let CLOCK_HEIGHT = CGFloat(412.0)
    private final let Z_POSITION = CGFloat(0)
    
    var clock: SKSpriteNode {
        return _clockNode
    }
    
    init(scene: SKScene) {
        _clockScene = scene
        createClockNode()
    }
    
    private func createClockNode() {
        _clockNode = SKSpriteNode(imageNamed: "Circle")
        _clockNode.size = CGSize(width: CLOCK_WIDTH, height: CLOCK_HEIGHT)
        _clockNode.position = CGPoint(x: _clockScene.frame.midX, y: _clockScene.frame.midY)
        _clockNode.zPosition = Z_POSITION
    }
    
}
