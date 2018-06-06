//
//  DiceHistoryMockRepository.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

class DiceHistoryMockRepository: DiceHistoryRepository {
    
    func store(_ diceResult: DiceResult) {
        print(diceResult)
    }
    
    func get() -> [DiceResult] {
        return []
    }
    
    func reset() {
        return
    }
    
}
