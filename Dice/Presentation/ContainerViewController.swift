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
    private let animator = UIViewPropertyAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecongizer = UITapGestureRecognizer(target: self, action: #selector(ContainerViewController.historyViewPressed))
        historyViewContainer.addGestureRecognizer(tapGestureRecongizer)
        
//        let swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ContainerViewController.historyViewPressed))
//        swipeUpGestureRecognizer.direction = .up
//        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(ContainerViewController.historyViewPressed))
//        swipeDownGestureRecognizer.direction = .down
//        historyViewContainer.addGestureRecognizer(swipeUpGestureRecognizer)
//        historyViewContainer.addGestureRecognizer(swipeDownGestureRecognizer)
        
        
//
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ContainerViewController.handlePan))
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
    
    private func handlePan(recognizer: UIPanGestureRecognizer) {
//        switch recognizer.state {
//        case .began:
//            animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut, animations: {
//                myView.transform = CGAffineTransform(translationX: 275, y: 0)
//                myView.alpha = 0
//            })
//            animator.startAnimation()
//            animator.pauseAnimation()
//        case .changed:
//            animator.fractionComplete = recognizer.translation(in: myView).x / 275
//        case .ended:
//            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
//        default:
//            ()
//        }
    }
    
    private func animateExpandHistoryView() {
        
        var screenHeight = UIScreen.main.bounds.height

        if #available(iOS 11.0, *) {
            // if we are on an iPhone X substract the space that the notch takes
            let window = UIApplication.shared.keyWindow
            screenHeight -= window?.safeAreaInsets.top ?? 0.0
        }
        
        let diceMaxSize: CGFloat = 100.0
        let fractionOfHeightForHistory: CGFloat = 0.75
        let fractionOfHeightForDice: CGFloat = 1.0 - fractionOfHeightForHistory
        
        let calculatedDiceSpace: CGFloat = fractionOfHeightForDice * screenHeight
        let dicePadding: CGFloat = 20.0
        let calculatedDiceSize: CGFloat = calculatedDiceSpace - 2.0 * dicePadding
        let diceHeight: CGFloat = diceMaxSize < calculatedDiceSize ? diceMaxSize : calculatedDiceSize
        let diceOffset = -1.0 * screenHeight * 0.5 + calculatedDiceSpace * 0.5 + dicePadding
        let historyViewHeight = screenHeight * fractionOfHeightForHistory
        
        let transitionAnimator = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 1, animations: {
            self.diceViewCenterVerticalConstraint.constant = diceOffset
            self.diceViewHeightConstraint.constant = diceHeight
            self.historyViewHeightConstraint.constant = historyViewHeight
            self.view.layoutIfNeeded()
        })
        
        transitionAnimator.startAnimation()
    }
    
   private func animateContractHistoryView() {
        let transitionAnimator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1, animations: {
            self.diceViewCenterVerticalConstraint.constant = -50.0
            self.diceViewHeightConstraint.constant = 240.0
            self.historyViewHeightConstraint.constant = 141.0
            self.view.layoutIfNeeded()
        })
    
        transitionAnimator.startAnimation()
    }
    
}

