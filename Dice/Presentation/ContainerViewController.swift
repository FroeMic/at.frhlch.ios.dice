//
//  ViewController.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet var historyViewContainer: UIView!
    @IBOutlet var diceViewCenterVerticalConstraint: NSLayoutConstraint!
    @IBOutlet var diceViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var historyViewHeightConstraint: NSLayoutConstraint!
    
    private var historyViewIsOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ContainerViewController.historyViewPressed))
        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ContainerViewController.historyViewPressed))
        swipeUpGestureRecognizer.direction = .up
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ContainerViewController.historyViewPressed))
        swipeDownGestureRecognizer.direction = .down
        historyViewContainer.addGestureRecognizer(swipeUpGestureRecognizer)
        historyViewContainer.addGestureRecognizer(swipeDownGestureRecognizer)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        becomeFirstResponder()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        resignFirstResponder()
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            Injection.shakeDelegate?.shakeEnded()
        }
    }
    
    @objc func historyViewPressed() {
        if historyViewIsOpen {
            animateContractHistoryView()
        } else {
            animateExpandHistoryView()
        }
        historyViewIsOpen = !historyViewIsOpen
    }
    
    private func animateExpandHistoryView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.diceViewCenterVerticalConstraint.constant = -270.0
            self.diceViewHeightConstraint.constant = 100.0
            self.historyViewHeightConstraint.constant = 600.0
            self.view.layoutIfNeeded()
        })
    }
    
   private func animateContractHistoryView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.diceViewCenterVerticalConstraint.constant = -50.0
            self.diceViewHeightConstraint.constant = 240.0
            self.historyViewHeightConstraint.constant = 141.0
            self.view.layoutIfNeeded()
        })
    }

    
}

