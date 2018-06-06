//
//  Dice.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation
import AFDateHelper

struct DiceResult: CustomStringConvertible {

    let result: DiceOption
    let time: Date
    
    var description: String {
        return "[" + result.description + "] " + time.toStringWithRelativeTime()
    }
    
    var timestamp: String {
        return time.toStringWithRelativeTime()
    }
}
