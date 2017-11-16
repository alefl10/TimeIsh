//
//  ClockScene.swift
//  TimeIsh
//
//  Created by Alejandro Ferrero on 11/14/17.
//  Copyright © 2017 Alejandro Ferrero. All rights reserved.
//

import UIKit
import SpriteKit

class ClockScene: SKScene {
    
    private var clockNode: ClockNode!
    private var handNode: HandNode!
    private var timeZoneNode: TimeZoneNode!
    private var dotNode: DotNode!
    private var clock: SKSpriteNode!
    private var hand: SKSpriteNode!
    private var timeZone: SKShapeNode!
    private var dot: SKShapeNode!
    
    private var gameStarted = false
    private var movingClockwise = Bool()
    private var currentQuadrant: String! = "start"
    
    private var Path = UIBezierPath()
    
    private final let PROPORTION = CGFloat(10.0)

//    MARK: FUTURE VARIABLES
    
//    var intersected = false

//    var LevelLabel = UILabel()
//
//
//    var currentLevel = Int()
//    var currentScore = Int()
//    var highLevel = Int()
//
//    var View1 = UIView()
//    var View2 = UIView()
    
    
    override func didMove(to view: SKView) {
        loadView()
    }
    
    
    func loadView(){
        movingClockwise = true
        
        scene?.backgroundColor = SKColor.black
        
        clockNode = ClockNode(scene: scene!)
        clock = clockNode.clock
        
        handNode = HandNode(scene: scene!, clockNode: clockNode.clock)
        hand = handNode.hand
        
        dotNode = DotNode(scene: scene!, clockNode: clockNode.clock)
        dot = dotNode.dot
        
        timeZoneNode = TimeZoneNode(scene: scene!, clockNode: clockNode.clock, proportion: PROPORTION, quadrant: currentQuadrant)
        timeZone = timeZoneNode.timeZone
        
        self.addChild(clock)
        self.addChild(hand)
        self.addChild(dot)
        self.addChild(timeZone)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameStarted {
            hand.run(rotateHand().reversed())
            movingClockwise = true
            gameStarted = true
        }
        else if gameStarted {
            if movingClockwise {
                hand.run(rotateHand().reversed())
                updateTimeZone()
            }
            else if !movingClockwise {
                hand.run(rotateHand())
                movingClockwise = true
            }
        }
    }
    
    
    private func updateTimeZone() {
        timeZone.removeFromParent()
        currentQuadrant = timeZoneNode.pickQuadrant(quadrant: currentQuadrant)
        timeZone = timeZoneNode.timeZone
        addChild(timeZoneNode.timeZone)
    }
    
    
    func rotateHand() -> SKAction{
        let dx = hand.position.x
        let dy = hand.position.y
        
        let rad = atan2(dy, dx)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: clock.size.width/3 + 30, startAngle: CGFloat(Double.pi / 3), endAngle: rad + CGFloat(Double.pi * 4), clockwise: true)
        let follow = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: true, speed: 200)
        
        return (SKAction.repeatForever(follow))
    }
    
    
//    MARK: FUTURE METHODS
    
//    func nextLevel(){
//        currentLevel += 1
//        currentScore = currentLevel
//        LevelLabel.text  = "\(currentScore)"
//        won()
//        if currentLevel > highLevel{
//            highLevel = currentLevel
//            let Defaults = UserDefaults.standard
//            Defaults.set(highLevel, forKey: "HighLevel")
//        }
//    }
//
//
//    func died(){
//        self.removeAllChildren()
//        let action1 = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: 0.2)
//        let action2 = SKAction.colorize(with: UIColor.black, colorBlendFactor: 1.0, duration: 0.2)
//        self.scene?.run(SKAction.sequence([action1,action2]))
//        intersected = false
//        gameStarted = false
//        LevelLabel.removeFromSuperview()
//        currentScore = currentLevel
//        self.loadView()
//    }
//
//
//    func won(){
//        self.removeAllChildren()
//        let action1 = SKAction.colorize(with: UIColor.green, colorBlendFactor: 1.0, duration: 0.2)
//        let action2 = SKAction.colorize(with: UIColor.black, colorBlendFactor: 1.0, duration: 0.2)
//        self.scene?.run(SKAction.sequence([action1,action2]))
//        intersected = false
//        gameStarted = false
//        LevelLabel.removeFromSuperview()
//        self.loadView()
//    }
//
//
//    override func update(_ currentTime: CFTimeInterval) {
//        /* Called before each frame is rendered */
//
//        if hand.intersects(Dot){
//            intersected = true
//
//        }
//        else{
//            if intersected == true{
//                if hand.intersects(Dot) == false{
//                    died()
//                }
//
//            }
//        }
//    }
    
}
