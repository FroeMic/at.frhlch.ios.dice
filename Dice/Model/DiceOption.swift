//
//  DiceOptions.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation
import UIKit

enum DiceOption: Int, CustomStringConvertible {
    
    /**
     * The number of enum values.
     */
    static let count: Int = 6
    
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    
    var image: UIImage {
        switch self {
        case .one:
            return UIImage(named: "dice_1")!
        case .two:
            return UIImage(named: "dice_2")!
        case .three:
            return UIImage(named: "dice_3")!
        case .four:
            return UIImage(named: "dice_4")!
        case .five:
            return UIImage(named: "dice_5")!
        case .six:
            return UIImage(named: "dice_6")!
        }
    }
    
    var description: String {
        switch self {
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        }
    }
    
   
}
