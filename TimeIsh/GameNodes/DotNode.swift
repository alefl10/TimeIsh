//
//  DotNode.swift
//  TimeIsh
//
//  Created by Alejandro Ferrero on 11/15/17.
//  Copyright © 2017 Alejandro Ferrero. All rights reserved.
//

import Foundation
import SpriteKit

import Foundation
import SpriteKit

class DotNode {
    
    private var path: UIBezierPath!
    
    private var _clockScene = SKScene()
    private var _dotNode: SKShapeNode!
    private var _clockNode: SKSpriteNode!
    
    private final let DOT_RADIUS = CGFloat(50.0)
    
    private final let Z_POSITION = CGFloat(3)
    
    var dot: SKShapeNode {
        return _dotNode
    }
    
    init(scene: SKScene, clockNode: SKSpriteNode) {
        _clockScene = scene
        _clockNode = clockNode
        createDotNode()
    }
    
    private func createDotNode() {
        path = UIBezierPath()
        path = UIBezierPath(ovalIn: CGRect(x: 0.0 - DOT_RADIUS/2, y: 0.0 - DOT_RADIUS/2, width: DOT_RADIUS, height: DOT_RADIUS))
        
        _dotNode = SKShapeNode(path: path.cgPath)
        _dotNode.fillColor = .red
        _dotNode.strokeColor = .yellow
        _dotNode.glowWidth = 2.0
        _dotNode.zPosition = Z_POSITION
        
    }
}
