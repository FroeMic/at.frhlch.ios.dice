//
//  File.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit
import AudioToolbox
import Spring

class DiceViewController: UIViewController {
    
    @IBOutlet var diceImageView: SpringImageView!
    
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
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        updateDiceImage()
        saveDiceResult()
    }
    
    private func updateDiceImage() {
        diceImageView.animation = "pop"
        diceImageView.curve = "easeIn"
        diceImageView.force =  0.3
        diceImageView.duration =  0.7
        diceImageView.animate()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.diceImageView.image = self.dice.result.image
        })
    }
    
    private func saveDiceResult() {
        let result = DiceResult(result: dice.result, time: Date())
        Injection.diceHistoryStore.store(result)
        Injection.diceHistoryStore.get()
    }
}
