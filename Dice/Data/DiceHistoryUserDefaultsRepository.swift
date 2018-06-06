//
//  DiceHistoryUserDefaultsRepository.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation
import AFDateHelper

class DiceHistoryUserDefaultsRepository {
    
    fileprivate let savedHistory = "diceHistory"
    fileprivate let defaults = UserDefaults.standard
    
    fileprivate func resultToDict(_ diceResult: DiceResult) -> Dictionary<String,String> {
        return [
            "result": diceResult.result.description,
            "time": diceResult.time.toString(format: .isoDateTimeMilliSec)
        ]
    }
    
    fileprivate func dictToResult(_ dict: Dictionary<String,String>) -> DiceResult? {
        guard let dateString = dict["time"],
            let time = Date(fromString: dateString, format: .isoDateTimeMilliSec) else {
            return nil
        }
        guard let resultString = dict["result"],
            let resultInt = Int(resultString),
            let result = DiceOption(rawValue: resultInt)  else {
            return nil
        }
        
        return DiceResult(result: result, time: time)
    }
    
}

extension DiceHistoryUserDefaultsRepository: DiceHistoryRepository {
    
    func store(_ diceResult: DiceResult) {
        let serializedResult = resultToDict(diceResult)
        var existingResults = defaults.array(forKey: savedHistory) ?? []
        
        existingResults.append(serializedResult)
        
        defaults.set(existingResults, forKey: savedHistory)
    }
    
    func get() -> [DiceResult] {
        let results = defaults.array(forKey: savedHistory) ?? []
        var diceResults: [DiceResult] = []
        for element in results {
            if let dict = element as? Dictionary<String, String>,
                let diceResult = dictToResult(dict) {
                diceResults.append(diceResult)
            }
        }

        return diceResults.reversed()
    }
    
    func reset() {
        defaults.set([], forKey: savedHistory)
    }
    
}
