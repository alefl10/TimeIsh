//
//  HandNode.swift
//  TimeIsh
//
//  Created by Alejandro Ferrero on 11/14/17.
//  Copyright © 2017 Alejandro Ferrero. All rights reserved.
//

import Foundation
import SpriteKit

class HandNode {
    
    private var _clockScene = SKScene()
    private var _handNode: SKSpriteNode!
    
    private final let HAND_WIDTH = CGFloat(312/2)
    private final let HAND_HEIGHT = CGFloat(7.0)
    private final let Z_ROTATION = CGFloat(3.14/2)
    private final let Z_POSITION = CGFloat(2)
    
    var hand: SKSpriteNode {
        return _handNode
    }
    
    init(scene: SKScene) {
        _clockScene = scene
        createHandNode()
    }
    
    private func createHandNode() {
        _handNode = SKSpriteNode(imageNamed: "Hand")
        _handNode.name = "handNode"
        _handNode.size = CGSize(width: HAND_WIDTH - 20, height: HAND_HEIGHT)
        _handNode.position = CGPoint(x: 0, y: HAND_WIDTH/2)
        _handNode.zRotation = Z_ROTATION
        _handNode.zPosition = Z_POSITION
    }
}
