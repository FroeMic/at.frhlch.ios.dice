//
//  DiceHistoryObserver.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

protocol DiceHistoryObserver: class {
    func update(_ diceResult: DiceResult)
}

protocol DiceHistoryPublisher: class {
    func subscribe(_ subscriber: DiceHistoryObserver)
    func unsubscribe(_ subscriber: DiceHistoryObserver)
    func notify(_ diceResult: DiceResult)
}
