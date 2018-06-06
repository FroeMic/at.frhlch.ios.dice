//
//  DiceHistoryRepository.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

protocol DiceHistoryRepository {
    
    /**
     * Stores a DiceResult persistently.
     */
    func store(_ diceResult: DiceResult)
    
    /**
     * Retrieves all store DiceResults.
     */
    func get() -> [DiceResult]
    
    /**
     * Removes all DiceResults.
     */
    func reset()
    
}
