//
//  CoreDataHandler.swift
//  TimeIsh
//
//  Created by Alejandro Ferrero on 11/29/17.
//  Copyright © 2017 Alejandro Ferrero. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHandler {
    
    init() {
        if checkFirstTime() {
            let play = NSEntityDescription.insertNewObject(forEntityName: "Play", into: CoreDataController.getContext()) as! Play
            play.firstTime = false
            let highestScore = NSEntityDescription.insertNewObject(forEntityName: "HighestScore", into: CoreDataController.getContext()) as! HighestScore
            highestScore.record = 0
            CoreDataController.saveContext()
        }
    }
    
    func updateHighestScore(newRecord: Int) {
        let currentRecord = fetchHighestScore()
        if currentRecord != nil {
            currentRecord!.record = Int32(newRecord)
            CoreDataController.saveContext()
        }
    }

    func getHighestScore() -> Int {
        if let highestScore = fetchHighestScore() {
            return Int(highestScore.record)
        }
        return 0
    }
    
    private func checkFirstTime() -> Bool {
        let fetchPlay:NSFetchRequest<Play> = Play.fetchRequest()
        do {
            let playEntries = try CoreDataController.getContext().fetch(fetchPlay)
            if playEntries.count == 0 {
                return true
            } else {
                return false
            }
        } catch  {
            print("There was an error within \"CoreDataHandler\" fetching \"Play\": \(error)")
            return false
        }
    }
    
    private func fetchHighestScore() -> HighestScore? {
//        var fectchedHighScores = [HighestScore]()
        let fetchHighScore:NSFetchRequest<HighestScore> = HighestScore.fetchRequest()
        do {
            let highScoreEntries = try CoreDataController.getContext().fetch(fetchHighScore)
            if highScoreEntries.count != 0 {
                for highScore in highScoreEntries {
                    return highScore
                }
            }
        } catch  {
            print("There was an error fetching HighScore: \(error)")
            return nil
        }
        return nil
    }
    
}
