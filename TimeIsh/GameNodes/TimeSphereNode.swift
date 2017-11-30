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
    private final let CLOCK_WIDTH = CGFloat(312/2)
    
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
    
    init(scene: SKScene) {
        _clockScene = scene
        createTimeSphereNode()
    }
    
    private func createTimeSphereNode() {
        _timeSphere = SKSpriteNode(imageNamed: "TimeSphere")
        _timeSphere.name = "timeSphereNode"
        _timeSphere.size = CGSize(width: TIME_ZONE_DIAMETER, height: TIME_ZONE_DIAMETER)
        _timeSphere.zPosition = Z_POSITION
    }
    
    func setRandomPosition(quadrant: String) -> String {
        let nextQuadrant = pickQuadrant(quadrant: quadrant)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: CLOCK_WIDTH - 30, startAngle: startAngle, endAngle: startAngle + CGFloat(Double.pi * 4), clockwise: true)
        _timeSphere.position = Path.currentPoint
        return nextQuadrant
    }
    
    
    private func pickQuadrant(quadrant: String) -> String {
        
        var newQuadrant: String
        switch quadrant {
        case "start":
            startAngle = CGFloat.random(min: 270, max: 310).degreesToRadians
            print(startAngle)
            return "q3"
        case "q1":
            repeat {
                findStartAngle()
            } while (startAngle <= CGFloat(80).degreesToRadians)
            if startAngle >= CGFloat(95).degreesToRadians && startAngle <= CGFloat(175).degreesToRadians {
                newQuadrant = "q2"
            } else if (startAngle >= CGFloat(185).degreesToRadians) && (startAngle <= CGFloat(265).degreesToRadians) {
                newQuadrant = "q3"
            } else {
                newQuadrant = "q4"
            }
            return newQuadrant
        case "q2":
            repeat {
                findStartAngle()
            } while (startAngle >= CGFloat(100).degreesToRadians && startAngle <= CGFloat(175).degreesToRadians)
            if startAngle >= CGFloat(5).degreesToRadians && startAngle <= CGFloat(80).degreesToRadians {
                newQuadrant = "q1"
            } else if (startAngle >= CGFloat(185).degreesToRadians) && (startAngle <= CGFloat(265).degreesToRadians) {
                newQuadrant = "q3"
            } else {
                newQuadrant = "q4"
            }
            return newQuadrant
        case "q3":
            repeat {
                findStartAngle()
            } while (startAngle >= CGFloat(185).degreesToRadians && startAngle <= CGFloat(265).degreesToRadians)
            if startAngle >= CGFloat(5).degreesToRadians && startAngle <= CGFloat(80).degreesToRadians {
                newQuadrant = "q1"
            } else if startAngle >= CGFloat(100).degreesToRadians && startAngle <= CGFloat(175).degreesToRadians {
                newQuadrant = "q2"
            } else {
                newQuadrant = "q4"
            }
            return newQuadrant
        case "q4":
            repeat {
                findStartAngle()
            } while (startAngle >= CGFloat(275).degreesToRadians && startAngle <= CGFloat(360).degreesToRadians)
            if startAngle >= CGFloat(5).degreesToRadians && startAngle <= CGFloat(80).degreesToRadians {
                newQuadrant = "q1"
            } else if startAngle >= CGFloat(100).degreesToRadians && startAngle <= CGFloat(175).degreesToRadians {
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
        repeat{
            startAngle = CGFloat.random(min: 0, max: 365).degreesToRadians
        } while (startAngle>=CGFloat(80).degreesToRadians && startAngle<=CGFloat(100).degreesToRadians || startAngle>=CGFloat(175).degreesToRadians && startAngle<=CGFloat(185).degreesToRadians || startAngle>=CGFloat(265).degreesToRadians && startAngle<=CGFloat(275).degreesToRadians || startAngle>=CGFloat(365).degreesToRadians && startAngle<=CGFloat(5).degreesToRadians)
        print(startAngle)
    }
    
    
}
