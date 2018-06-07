//
//  File.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit
import Spring

class DiceViewController: UIViewController {
    
    @IBOutlet var diceImageView: SpringImageView!
    
    private let dice = Dice()
    private let notification = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DiceViewController.rollDice))
        diceImageView.addGestureRecognizer(gestureRecognizer)
        
        Injection.shakeDelegate = self
    }


    @objc
    fileprivate func rollDice() {
        dice.roll()
        updateDiceImage()
        notification.notificationOccurred(.success)
        saveDiceResult()
    }
    
    private func updateDiceImage() {
        diceImageView.animation = "pop"
        diceImageView.curve = "easeIn"
        diceImageView.force =  0.3
        diceImageView.duration =  0.7
        diceImageView.animate()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            self.diceImageView.image = self.dice.result.image
        })
    }
    
    private func saveDiceResult() {
        let result = DiceResult(result: dice.result, time: Date())
        Injection.diceHistoryStore.store(result)
    }
}

extension DiceViewController: ShakeDelegate {
    
    func shakeEnded() {
        rollDice()
    }
}
