//
//  LevelHandler.swift
//  TimeIsh
//
//  Created by Alejandro Ferrero on 11/29/17.
//  Copyright © 2017 Alejandro Ferrero. All rights reserved.
//

import Foundation
import SpriteKit

class LevelHandler {
    
    private final var scene: SKScene!
    private var timeSpheres = [SKSpriteNode]()
    private var currentQuadrant: String! = "start"
    private final let SPEED_FACTOR = 5
    private let coreData = CoreDataHandler()
    
    var _quadrant: String {
        return currentQuadrant
    }
    
    var _timeSpheres: [SKSpriteNode] {
        return timeSpheres
    }
    
    func nextLevel(scene: SKScene, level: Int){
        self.scene = scene
        checkHighestScore(level: level)
        switch level {
        case 1...5:
            multipleDots(level: level)
//        case 5..<10:
//            return CGFloat(level*SPEED_FACTOR)
//        case 10..<15:
//        //Decrease TimeSphere size
//        case 15..<20:
//        //Bonus Levels
        default:
            multipleDots(level: 5)
            print("New levels are yet to come")
//            return CGFloat(0)
        }
    }
    
    private func multipleDots(level: Int) {
        var overlap = false
        for index in 0..<level {
            print("Time Spheres Count BEFORE: \(timeSpheres.count)")
            let timeSphereNode = TimeSphereNode(scene: scene!)
            currentQuadrant = timeSphereNode.setRandomPosition(quadrant: currentQuadrant)
            timeSpheres.append(timeSphereNode.timeSphere)
            print("Time Spheres Count AFTER: \(timeSpheres.count)")
            scene.addChild(timeSpheres[index])
            if timeSpheres.count > 1 {
                if timeSpheresOverlapping() {
                    for timeSphere in timeSpheres {
                        timeSphere.removeFromParent()
                    }
                    overlap = true
                    reset()
                    multipleDots(level: level)
                }
                if overlap {
                    break
                }
            }
        }
    }
    
    private func checkHighestScore(level: Int) {
        if level > coreData.getHighestScore() {
            coreData.updateHighestScore(newRecord: (level))
        }
    }
    
    private func timeSpheresOverlapping() -> Bool{
        var counter = timeSpheres.count
        while counter > 1 {
            for timeSphere in timeSpheres {
                if (timeSpheres.last?.intersects(timeSphere))! {
                    return true
                }
                counter -= 1
                if counter == 1 {
                    break
                }
            }
        }
        return false
    }
    
    func deleteTimeSphere(mustTapTimeSphere: SKSpriteNode) {
        mustTapTimeSphere.removeFromParent()
        let indexRemove = timeSpheres.index(of: mustTapTimeSphere)
        timeSpheres.remove(at: indexRemove!)
    }
    
    func reset() {
        timeSpheres.removeAll()
        currentQuadrant = "start"
    }
    
}
