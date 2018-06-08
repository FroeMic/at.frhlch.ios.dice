//
//  Dice.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

class Dice {
    
    private(set) var result: DiceOption = .one
    
    init() {
        roll()
    }
    
    func roll() {
        let randomNumber = selectRandom(min: 1, max: DiceOption.count)
        self.result =  DiceOption(rawValue: randomNumber)!
    }
    
    private func selectRandom(min: Int = 0, max: Int = 6) -> Int{
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}
