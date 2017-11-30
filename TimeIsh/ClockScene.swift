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
//    private var timeSphereNode: TimeSphereNode!
    private var dotNode: DotNode!
    private var clock: SKSpriteNode!
    private var hand: SKSpriteNode!
//    private var timeSpheres = [SKSpriteNode]()
    private var dot: SKShapeNode!
    
    private var highScoreLabel : SKLabelNode!
    private var underHighScoreLabel : SKLabelNode!
    private var currentLevelLabel : SKLabelNode!
    private var underCurrentLevelLabel : SKLabelNode!
    
    private var gameStarted = false
    private var intersected = false
    private var movingClockwise = Bool()
//    private var currentQuadrant: String! = "start"
    private var currentSpeed = CGFloat(125)
    private var highestScore = 1
    private var currentLevel = 1
    
    private var mustTapTimeSphere: SKSpriteNode!
    
    private var Path = UIBezierPath()
    
    private let coreData = CoreDataHandler()
    private let levelHandler = LevelHandler()

//    MARK: FUTURE VARIABLES

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
    
    
    private func loadView(){
        movingClockwise = true
        
        scene?.backgroundColor = SKColor.black
        
        clockNode = ClockNode(scene: scene!)
        clock = clockNode.clock
        handNode = HandNode(scene: scene!)
        hand = handNode.hand
        dotNode = DotNode(scene: scene!)
        dot = dotNode.dot
        
        self.addChild(clock)
        self.addChild(hand)
        self.addChild(dot)
        addLabels()
        
        levelHandler.nextLevel(scene: scene!, level: currentLevel)
        
//        for index in 0..<currentLevel {
//            addTimeSphere(index: index)
//        }
    }
    
    private func addLabels() {
        highestScore = coreData.getHighestScore()
        highScoreLabel = SKLabelNode()
        highScoreLabel.position = CGPoint(x: 110, y: -280)
        highScoreLabel.text = "\(highestScore)"
        highScoreLabel.color = SKColor.white
        highScoreLabel.fontName = "Menlo"
        highScoreLabel.fontSize = 100
        highScoreLabel.zPosition = 4
        
        underHighScoreLabel = SKLabelNode()
        underHighScoreLabel.position = CGPoint(x: 110, y: -310)
        underHighScoreLabel.text = "Record"
        underHighScoreLabel.color = SKColor.white
        underHighScoreLabel.fontName = "Menlo"
        underHighScoreLabel.fontSize = 20
        underHighScoreLabel.zPosition = 4
        
        currentLevelLabel = SKLabelNode()
        currentLevelLabel.position = CGPoint(x: -110, y: -280)
        currentLevelLabel.text = "\(currentLevel)"
        currentLevelLabel.color = SKColor.white
        currentLevelLabel.fontName = "Menlo"
        currentLevelLabel.fontSize = 100
        currentLevelLabel.zPosition = 4
        
        underCurrentLevelLabel = SKLabelNode()
        underCurrentLevelLabel.position = CGPoint(x: -110, y: -310)
        underCurrentLevelLabel.text = "Level"
        underCurrentLevelLabel.color = SKColor.white
        underCurrentLevelLabel.fontName = "Menlo"
        underCurrentLevelLabel.fontSize = 20
        underCurrentLevelLabel.zPosition = 4
        
        self.addChild(highScoreLabel)
        self.addChild(underHighScoreLabel)
        self.addChild(currentLevelLabel)
        self.addChild(underCurrentLevelLabel)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameStarted {
            hand.run(rotateHand().reversed())
            gameStarted = true
        } else {
            hand.run(rotateHand().reversed())
            if intersected {
                levelHandler.deleteTimeSphere(mustTapTimeSphere: mustTapTimeSphere)
                intersected = false
                if levelHandler._timeSpheres.count == 0 {
                    won()
                }
            } else {
                died()
            }
        }
    }
    
//    private func addTimeSphere(index: Int) {
//        let timeSphereNode = TimeSphereNode(scene: scene!, clockNode: clockNode.clock)
//        currentQuadrant = timeSphereNode.setRandomPosition(quadrant: currentQuadrant)
//        timeSpheres.append(timeSphereNode.timeSphere)
//        print("Next quadrant: \(currentQuadrant!)")
//        addChild(timeSpheres[index])
//    }
    
//    private func deleteTimeSphere() {
//        mustTapTimeSphere.removeFromParent()
//        let indexRemove = timeSpheres.index(of: mustTapTimeSphere)
//        timeSpheres.remove(at: indexRemove!)
//        intersected = false
//    }
    
    
    private func rotateHand() -> SKAction{
        let dx = hand.position.x
        let dy = hand.position.y
        let rad = atan2(dy, dx)
        
        Path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: clock.size.width/4, startAngle: CGFloat(Double.pi / 2), endAngle: rad + CGFloat(Double.pi * 4), clockwise: true)
        let follow = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: true, speed: currentSpeed)
        
        return (SKAction.repeatForever(follow))
    }
    
    private func won(){
        resetScene()
        let action1 = SKAction.colorize(with: UIColor.green, colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorize(with: UIColor.black, colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.run(SKAction.sequence([action1,action2]))
        currentLevel += 1
//        currentSpeed += levelHandler.nextLevel(scene: scene!, level: currentLevel)
        self.loadView()
    }
    
    private func died(){
        resetScene()
        currentLevel = 1
        let action1 = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorize(with: UIColor.black, colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.run(SKAction.sequence([action1,action2]))
        //        currentScore = currentLevel
        self.loadView()
    }
    
    private func resetScene() {
        self.removeAllChildren()
        levelHandler.reset()
        intersected = false
        gameStarted = false
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        for timeSphere in levelHandler._timeSpheres {
            if hand.intersects(timeSphere){
                intersected = true
                mustTapTimeSphere = timeSphere
            }
            else {
                if intersected == true {
                    if hand.intersects(mustTapTimeSphere) == false{
                        died()
                    }
                }
            }
        }
        
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
    
}
