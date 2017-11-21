//
//  TimeZoneNode.swift
//  TimeIsh
//
//  Created by Alejandro Ferrero on 11/15/17.
//  Copyright © 2017 Alejandro Ferrero. All rights reserved.
//

import Foundation
import SpriteKit

// MARK: This class cannot be used as the size of the _timeZoneNode cannot be determined precisely

class TimeZoneNode {
    
    private var path: UIBezierPath!
    
    private var _clockScene: SKScene = SKScene()
    private var _timeZoneNode: SKShapeNode!
    private var _clockNode: SKSpriteNode!
    private var _proportion: CGFloat

    private var _startAngle: CGFloat!
    private var min = CGFloat(180)
    private var max = CGFloat(360)
    
    private var start = true
    
    private final let Z_POSITION = CGFloat(1)
    
    var timeZone: SKShapeNode {
        return _timeZoneNode
    }
    
    init(scene: SKScene, clockNode: SKSpriteNode, proportion: CGFloat, quadrant: String) {
        _clockScene = scene
        _clockNode = clockNode
        _proportion = proportion
        pickQuadrant(quadrant: quadrant)
        createTimeZoneNode()
    }
    
    private func createTimeZoneNode () {
        
        let center = CGPoint(x: _clockScene.frame.midX, y: _clockScene.frame.midX)
        let arc = CGFloat.pi * 2 * _proportion / 100
        
        path = UIBezierPath()
        path.move(to: center)
        path.addLine(to: CGPoint(x: center.x + (_clockNode.size.width/2 - 6) * cos(_startAngle), y: center.y + (_clockNode.size.width/2 - 6) * sin(_startAngle)))
        path.addArc(withCenter: center, radius: _clockNode.size.width/2 - 6, startAngle: _startAngle, endAngle: arc + _startAngle, clockwise: true)
        path.addLine(to: CGPoint(x: center.x, y: center.y ))
        
        _timeZoneNode = SKShapeNode(path: path.cgPath)
        _timeZoneNode.zPosition = Z_POSITION
        _timeZoneNode.fillColor = .blue
        _timeZoneNode.strokeColor = .blue
        _timeZoneNode.glowWidth = 0.5
        
    }
    
    
    func pickQuadrant(quadrant: String) -> String {
        
        if start {
            _startAngle = CGFloat.random(min: 270, max: 360).degreesToRadians
            print(_startAngle)
            start = false
            return ""
        }
        
        var newQuadrant: String
        switch quadrant {
        case "start":
            _startAngle = CGFloat.random(min: 180, max: 270).degreesToRadians
            print(_startAngle)
            createTimeZoneNode()
            return "q3"
        case "q1":
            repeat {
                findStartAngle()
            } while (_startAngle <= CGFloat(90).degreesToRadians)
            if _startAngle <= CGFloat(180).degreesToRadians {
                newQuadrant = "q2"
            } else if (_startAngle >= CGFloat(180).degreesToRadians) && (_startAngle <= CGFloat(270).degreesToRadians) {
               newQuadrant = "q3"
            } else {
               newQuadrant = "q4"
            }
            return newQuadrant
        case "q2":
            repeat {
                findStartAngle()
            } while (_startAngle >= CGFloat(90).degreesToRadians && _startAngle <= CGFloat(180).degreesToRadians)
            if _startAngle <= CGFloat(90).degreesToRadians {
                newQuadrant = "q1"
            } else if (_startAngle >= CGFloat(180).degreesToRadians) && (_startAngle <= CGFloat(270).degreesToRadians) {
                newQuadrant = "q3"
            } else {
                newQuadrant = "q4"
            }
            return newQuadrant
        case "q3":
            repeat {
                findStartAngle()
            } while (_startAngle >= CGFloat(180).degreesToRadians && _startAngle <= CGFloat(270).degreesToRadians)
            if _startAngle <= CGFloat(90).degreesToRadians {
                newQuadrant = "q1"
            } else if (_startAngle >= CGFloat(90).degreesToRadians) && (_startAngle <= CGFloat(180).degreesToRadians) {
                newQuadrant = "q2"
            } else {
                newQuadrant = "q4"
            }
            return newQuadrant
        case "q4":
            repeat {
                findStartAngle()
            } while (_startAngle >= CGFloat(270).degreesToRadians)
            if _startAngle <= CGFloat(90).degreesToRadians {
                newQuadrant = "q1"
            } else if (_startAngle >= CGFloat(90).degreesToRadians) && (_startAngle <= CGFloat(180).degreesToRadians) {
                newQuadrant = "q2"
            } else {
                newQuadrant = "q3"
            }
            return newQuadrant
        default:
            print("Changing quadrant produced an ERROR!")
            return "q1"
        }
    }
    
    
    private func findStartAngle(){
        _startAngle = CGFloat.random(min: 0, max: 365).degreesToRadians
        createTimeZoneNode()
        print(_startAngle)
    }
    
}
