//
//  TimeZoneNode.swift
//  TimeIsh
//
//  Created by Alejandro Ferrero on 11/15/17.
//  Copyright © 2017 Alejandro Ferrero. All rights reserved.
//

import Foundation
import SpriteKit

class TimeZoneNode {
    
    private var path: UIBezierPath!
    
    private var _clockScene: SKScene = SKScene()
    private var _timeZoneNode: SKShapeNode!
    private var _clockNode: SKSpriteNode!
    private var _proportion: CGFloat
    
    private final let Z_POSITION = CGFloat(1)
    
    init(scene: SKScene, clockNode: SKSpriteNode, proportion: CGFloat) {
        _clockScene = scene
        _clockNode = clockNode
        _proportion = proportion
    }
    
    var timeZone: SKShapeNode {
        createTimeZoneNode()
        return _timeZoneNode
    }
    
    private func createTimeZoneNode () {
        
        let center = CGPoint(x: _clockScene.frame.midX, y: _clockScene.frame.midX)
        let startAngle = CGFloat(0.0).degreesToRadians
        let arc = CGFloat.pi * 2 * _proportion / 100
        
        path = UIBezierPath()
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x + (_clockNode.size.width/2 - 6) * cos(startAngle), y: center.y + (_clockNode.size.width/2 - 6) * sin(startAngle)))
        path.addArc(withCenter: center, radius: _clockNode.size.width/2 - 6, startAngle: startAngle, endAngle: arc + startAngle, clockwise: true)
        path.addLine(to: CGPoint(x: center.x, y: center.y ))
        
        _timeZoneNode = SKShapeNode(path: path.cgPath)
        _timeZoneNode.zPosition = Z_POSITION
        _timeZoneNode.fillColor = .orange
        _timeZoneNode.strokeColor = .yellow
        _timeZoneNode.glowWidth = 0.5
        
    }
    
}
