//
//  File.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class DiceViewController: UIViewController {
    
    @IBOutlet var diceImageView: UIImageView!
    
    private let dice = Dice()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        becomeFirstResponder()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DiceViewController.rollDice))
        diceImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            rollDice()
        }
    }

    @objc
    func rollDice() {
        dice.roll()
        updateDiceImage()
    }
    
    private func updateDiceImage() {
        diceImageView.image = dice.result.image
    }
}
