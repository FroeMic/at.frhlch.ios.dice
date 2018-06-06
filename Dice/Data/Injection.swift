//
//  Injection.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

class Injection {
    
    static let diceHistoryStore: DiceHistoryRepository = DiceHistoryMockRepository()
    
}
