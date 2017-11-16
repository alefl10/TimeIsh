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
    private var clock: SKSpriteNode!
    private var hand: SKSpriteNode!
    private var timeZone: SKShapeNode!
    
    var Dot = SKSpriteNode()
    
    var Path = UIBezierPath()
    
    var gameStarted = Bool()
    
    var movingClockwise = Bool()
    var intersected = false
    
    
    var LevelLabel = UILabel()
    
    
    var currentLevel = Int()
    var currentScore = Int()
    var highLevel = Int()
    
    var View1 = UIView()
    var View2 = UIView()
    
    override func didMove(to view: SKView) {
        
        loadView()
//        let Defaults = UserDefaults.standard as UserDefaults!
//        if Defaults?.integer(forKey: "HighLevel") != 0{
//            highLevel = Defaults?.integer(forKey: "HighLevel") as Int!
//            currentLevel = highLevel
//            currentScore = currentLevel
//            LevelLabel.text = "\(currentScore)"
//        }
//        else{
//
//            Defaults?.set(1, forKey: "HighLevel")
//        }
//
//        View1 = UIView(frame: CGRect(origin: CGPoint(x: self.frame.width / 2 + 120, y: self.frame.height / 2), size: CGSize(width: self.frame.width, height: self.frame.height)))
//        View1.addSubview(view)
    }
    
    func loadView(){
        
        movingClockwise = true
        
        scene?.backgroundColor = SKColor.black
        
        clockNode = ClockNode(scene: scene!)
        clock = clockNode.clock
        
        handNode = HandNode(scene: scene!, clockNode: clockNode.clock)
        hand = handNode.hand
        
        timeZoneNode = TimeZoneNode(scene: scene!, clockNode: clockNode.clock, proportion: 15.0)
        timeZone = timeZoneNode.timeZone
        
        
        self.addChild(clock)
        self.addChild(timeZone)
        self.addChild(hand)
        
        AddDot()
        
        
        LevelLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 100))
        LevelLabel.center = (self.view?.center)!
        LevelLabel.text = "\(currentScore)"
        LevelLabel.textColor = SKColor.darkGray
        LevelLabel.textAlignment = NSTextAlignment.center
        LevelLabel.font = UIFont.systemFont(ofSize: 60)
        self.View1.addSubview(LevelLabel)
        
        
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
                movingClockwise = false
            }
            else if !movingClockwise {
                hand.run(rotateHand())
                movingClockwise = true
            }
            DotTouched()
        }
    }
    
    
    
    func AddDot(){
        
        Dot = SKSpriteNode(imageNamed: "Dot")
        Dot.size = CGSize(width: 30, height: 30)
        Dot.zPosition = 1.0
        
        let dx = hand.position.x - self.frame.width / 2
        let dy = hand.position.y - self.frame.height / 2
        
        let rad = atan2(dy, dx)
        
        if movingClockwise == true{
            let tempAngle = CGFloat.random(min: rad - 1.0, max: rad - 2.5)
            let Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: tempAngle, endAngle: tempAngle + CGFloat(Double.pi * 4), clockwise: true)
            Dot.position = Path2.currentPoint
            
        }
        else if movingClockwise == false{
            let tempAngle = CGFloat.random(min: rad + 1.0, max: rad + 2.5)
            let Path2 = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: 120, startAngle: tempAngle, endAngle: tempAngle + CGFloat(Double.pi * 4), clockwise: true)
            Dot.position = Path2.currentPoint
            
            
        }
        self.addChild(Dot)
    }
    
    
    func rotateHand() -> SKAction{
        let dx = hand.position.x
        let dy = hand.position.y
        
        let rad = atan2(dy, dx)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 100, startAngle: CGFloat(Double.pi / 2), endAngle: rad + CGFloat(Double.pi * 4), clockwise: true)
        let follow = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: true, speed: 200)
        
        return (SKAction.repeatForever(follow))
    }

    
    func DotTouched(){
        if intersected == true{
            Dot.removeFromParent()
            AddDot()
            intersected = false
            
            currentScore -= 1
            LevelLabel.text = "\(currentScore)"
            if currentScore <= 0{
                nextLevel()
                
            }
        }
        else if intersected == false{
            died()
        }
        
    }
    
    func nextLevel(){
        currentLevel += 1
        currentScore = currentLevel
        LevelLabel.text  = "\(currentScore)"
        won()
        if currentLevel > highLevel{
            highLevel = currentLevel
            let Defaults = UserDefaults.standard
            Defaults.set(highLevel, forKey: "HighLevel")
        }
    }
    
    
    func died(){
        self.removeAllChildren()
        let action1 = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorize(with: UIColor.black, colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.run(SKAction.sequence([action1,action2]))
        intersected = false
        gameStarted = false
        LevelLabel.removeFromSuperview()
        currentScore = currentLevel
        self.loadView()
    }
    
    
    func won(){
        self.removeAllChildren()
        let action1 = SKAction.colorize(with: UIColor.green, colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorize(with: UIColor.black, colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.run(SKAction.sequence([action1,action2]))
        intersected = false
        gameStarted = false
        LevelLabel.removeFromSuperview()
        self.loadView()
        
        
    }
    
    
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if hand.intersects(Dot){
            intersected = true
            
        }
        else{
            if intersected == true{
                if hand.intersects(Dot) == false{
                    died()
                }
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    private var clock = SKSpriteNode()
//    private var hand = SKSpriteNode()
////    private var clockJoint: SKPhysicsJointPin! = SKPhysicsJointPin()
//
//    var path = UIBezierPath()
//    let zeroAngle: CGFloat = 0.0
//
//    var clockwise = Bool()
//
//    var started = false
//    var touched = false
//
//
//
//
//    override func didMove(to view: SKView) {
//        clock = SKSpriteNode(imageNamed: "Clock.png")
//        clock.name = "clockNode"
////        clock.physicsBody = SKPhysicsBody(rectangleOf: clock.frame.size)
////        clock.physicsBody!.isDynamic = false
//        clock.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//
//        hand = SKSpriteNode(imageNamed: "Hand.png")
//        hand.name = "handNode"
//        hand.anchorPoint = CGPoint(x: 0, y: 1)
//        hand.position = CGPoint(x: frame.minX, y: frame.minY)
//        print(hand.position)
//        print(self.frame.width/2)
//        print(self.frame.height/2)
////        hand.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 165)
//
////        hand.physicsBody = SKPhysicsBody(rectangleOf: hand.frame.size)
////        hand.physicsBody!.allowsRotation = true
////        hand.physicsBody!.isDynamic = true
////        hand.physicsBody!.mass = 0.0
//
////        self.addChild(clock)
////        clock.zPosition = 0
//        self.addChild(hand)
//        hand.zPosition = 2
//
//
////        clockJoint = SKPhysicsJointPin.joint(withBodyA: clock.physicsBody!, bodyB: hand.parent!.physicsBody!, anchor:  pinPoint)
////        self.physicsWorld.add(clockJoint)
//
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if !started {
//            clockwise = true
//            runClockwise()
//            started = true
//        } else {
//
//        }
//    }
//
//    func moveClockwise() {
//
//    }
//
//    func runClockwise() {
////        let pinPoint = CGPoint(x: self.frame.midX, y: self.frame.midY)
////        let clockJoint = SKPhysicsJointPin.joint(withBodyA: clock.physicsBody!, bodyB: hand.physicsBody!, anchor: pinPoint)
////
////        self.physicsWorld.add(clockJoint)
//
//        let action = SKAction.rotate(byAngle: -CGFloat(Double.pi) * 2, duration: 3)  //
//        hand.run(action, completion: {
//            print("done")
//        })
////        path = makePath(angle: getRadian())
////        let spinHand = SKAction.follow(path.cgPath, asOffset: false, orientToPath: true, speed: 200)
////        hand.run(SKAction.repeatForever(spinHand).reversed())
////        hand.run(SKAction.repeatForever(spinHand))
//    }
//
////    func getRadian() -> CGFloat {
////        let dx = hand.position.x - self.frame.midX
////        let dy = hand.position.y - self.frame.midY
////
////        return atan2(dy, dx)
////    }
////
////    func makePath(angle: CGFloat) -> UIBezierPath {
////        return UIBezierPath(arcCenter: CGPoint(x: self.frame.midX, y: self.frame.midY),
////                            radius: 200,
////                            startAngle: angle,
////                            endAngle: angle + CGFloat(Double.pi * 2),
////                            clockwise: true)
////    }
    
}
