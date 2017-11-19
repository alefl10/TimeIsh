//
//  TimeSphereNode.swift
//  TimeIsh
//
//  Created by Alejandro Ferrero on 11/18/17.
//  Copyright © 2017 Alejandro Ferrero. All rights reserved.
//

import Foundation
import SpriteKit

class TimeSphereNode {
    private var _clockScene = SKScene()
    private var _timeSphere: SKSpriteNode!
    private var _clockNode: SKSpriteNode!
    
    private var startAngle: CGFloat!
    private var min = CGFloat(180)
    private var max = CGFloat(360)
    
    private var start = true
    
    private var Path = UIBezierPath()
    
    private final let TIME_ZONE_DIAMETER = CGFloat(30.0)
    private final let Z_POSITION = CGFloat(1)
    
    var timeSphere: SKSpriteNode {
        return _timeSphere
    }
    
    init(scene: SKScene, clockNode: SKSpriteNode) {
        _clockScene = scene
        _clockNode = clockNode
        createTimeSphereNode()
    }
    
    private func createTimeSphereNode() {
        _timeSphere = SKSpriteNode(imageNamed: "TimeSphere")
        _timeSphere.name = "timeSphereNode"
        _timeSphere.size = CGSize(width: TIME_ZONE_DIAMETER, height: TIME_ZONE_DIAMETER)
        _timeSphere.zPosition = Z_POSITION
    }
    
    func setRandomPosition(quadrant: String) -> String {
//        let dx = -_clockScene.frame.width / 2
//        let dy = _clockNode.size.width/4 - 3
//        let rad = atan2(dy, dx)
        
        let nextQuadrant = pickQuadrant(quadrant: quadrant)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: _clockNode.size.width/2 - 30, startAngle: startAngle, endAngle: startAngle + CGFloat(Double.pi * 4), clockwise: true)
        _timeSphere.position = Path.currentPoint
        return nextQuadrant
        
        //        MARK: In case setRandomPosition had a direction: String argument
        
//        switch direction {
//        case "clockwise":
//            let tempAngle = CGFloat.random(min: rad - 1.0, max: rad - 2.5)
//            Path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 165, startAngle: tempAngle, endAngle: tempAngle + CGFloat(Double.pi * 4), clockwise: true)
//            _timeSphere.position = Path.currentPoint
//        case "counterClockwise":
//            let tempAngle = CGFloat.random(min: rad + 1.0, max: rad + 2.5)
//            Path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 165, startAngle: tempAngle, endAngle: tempAngle + CGFloat(Double.pi * 4), clockwise: true)
//            _timeSphere.position = Path.currentPoint
//        default:
//            print("direction argument was passed with a wrong value: \(direction)")
//        }
    }
    
    
    private func pickQuadrant(quadrant: String) -> String {
        
//        if start {
//            startAngle = CGFloat.random(min: 270, max: 360).degreesToRadians
//            print(startAngle)
//            start = false
//            return "q3"
//        }
        
        var newQuadrant: String
        switch quadrant {
        case "start":
            startAngle = CGFloat.random(min: 270, max: 310).degreesToRadians
            print(startAngle)
//            createTimeZoneNode()
            return "q3"
        case "q1":
            repeat {
                findStartAngle()
            } while (startAngle <= CGFloat(90).degreesToRadians)
            if startAngle <= CGFloat(180).degreesToRadians {
                newQuadrant = "q2"
            } else if (startAngle >= CGFloat(180).degreesToRadians) && (startAngle <= CGFloat(270).degreesToRadians) {
                newQuadrant = "q3"
            } else {
                newQuadrant = "q4"
            }
            return newQuadrant
        case "q2":
            repeat {
                findStartAngle()
            } while (startAngle >= CGFloat(90).degreesToRadians && startAngle <= CGFloat(180).degreesToRadians)
            if startAngle <= CGFloat(90).degreesToRadians {
                newQuadrant = "q1"
            } else if (startAngle >= CGFloat(180).degreesToRadians) && (startAngle <= CGFloat(270).degreesToRadians) {
                newQuadrant = "q3"
            } else {
                newQuadrant = "q4"
            }
            return newQuadrant
        case "q3":
            repeat {
                findStartAngle()
            } while (startAngle >= CGFloat(180).degreesToRadians && startAngle <= CGFloat(270).degreesToRadians)
            if startAngle <= CGFloat(90).degreesToRadians {
                newQuadrant = "q1"
            } else if (startAngle >= CGFloat(90).degreesToRadians) && (startAngle <= CGFloat(180).degreesToRadians) {
                newQuadrant = "q2"
            } else {
                newQuadrant = "q4"
            }
            return newQuadrant
        case "q4":
            repeat {
                findStartAngle()
            } while (startAngle >= CGFloat(270).degreesToRadians)
            if startAngle <= CGFloat(90).degreesToRadians {
                newQuadrant = "q1"
            } else if (startAngle >= CGFloat(90).degreesToRadians) && (startAngle <= CGFloat(180).degreesToRadians) {
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
        startAngle = CGFloat.random(min: 0, max: 365).degreesToRadians
//        createTimeZoneNode()
        print(startAngle)
    }
    
    
}
