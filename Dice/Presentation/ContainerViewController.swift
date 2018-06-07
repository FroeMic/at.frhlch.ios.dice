//
//  ViewController.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit
import Spring

class ContainerViewController: UIViewController {
    
    @IBOutlet var panGestureView: UIView!
    @IBOutlet var historyViewContainer: SpringView!
    @IBOutlet var panGestureViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var diceViewCenterVerticalConstraint: NSLayoutConstraint!
    @IBOutlet var diceViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var historyViewHeightConstraint: NSLayoutConstraint!
    
    private var historyViewIsOpen = false 
    private var animationProgress: CGFloat = 0.0
    private var animator = UIViewPropertyAnimator()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecongizer = UITapGestureRecognizer(target: self, action: #selector(ContainerViewController.historyViewPressed))
        panGestureView.addGestureRecognizer(tapGestureRecongizer)
        
        let panGestureRecognizer = InstantPanGestureRecognizer(target: self, action: #selector(ContainerViewController.handlePan))
        panGestureView.addGestureRecognizer(panGestureRecognizer)
    }

    override func viewDidAppear(_ animated: Bool) {
        historyViewContainer.animation = "fadeInUp"
        historyViewContainer.curve = "easeIn"
        historyViewContainer.duration =  0.8
        historyViewContainer.force = 1.0
        historyViewContainer.animate()

        becomeFirstResponder()
        
        super.viewDidAppear(animated)
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
            let transitionAnimator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1, animations: {
                self.animateContractHistoryView()
            })
            transitionAnimator.startAnimation()
        } else {
            let transitionAnimator = UIViewPropertyAnimator(duration: 0.4, dampingRatio: 1, animations: {
                self.animateExpandHistoryView()
            })
            transitionAnimator.startAnimation()
        }
        historyViewIsOpen = !historyViewIsOpen
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            if historyViewIsOpen {
                animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut, animations: {
                    self.animateContractHistoryView()
                })
                
                animator.addCompletion{ position in
                    switch position {
                    case .start:
                        self.historyViewIsOpen = true
                    case .end:
                        self.historyViewIsOpen = false
                    case .current:
                        ()
                    }
                }
            } else {
                animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut, animations: {
                    self.animateExpandHistoryView()
                })
                animator.addCompletion{ position in
                    switch position {
                    case .start:
                        self.historyViewIsOpen = false
                    case .end:
                        self.historyViewIsOpen = true
                    case .current:
                        ()
                    }
                }
            }
            animator.pauseAnimation()
            animationProgress = animator.fractionComplete
        case .changed:
            let translation = recognizer.translation(in: historyViewContainer)
            var screenHeight = UIScreen.main.bounds.height
            
            if #available(iOS 11.0, *) {
                // if we are on an iPhone X substract the space that the notch takes
                let window = UIApplication.shared.keyWindow
                screenHeight -= window?.safeAreaInsets.top ?? 0.0
            }
            let fractionOfHeightForHistory: CGFloat = 0.75
            let finalHistoryViewHeight: CGFloat = screenHeight * fractionOfHeightForHistory
            let initialHistoryViewHeight:CGFloat = 141.0

            let differenceInHeight = finalHistoryViewHeight - initialHistoryViewHeight
            
            let fractionComplete = abs(translation.y) / differenceInHeight + animationProgress

            animator.fractionComplete = fractionComplete
        case .ended:
            
            // variable setup
            let yVelocity = recognizer.velocity(in: historyViewContainer).y
            let shouldClose = yVelocity > 0
            
            // if there is no motion, continue all animations and exit early
            if yVelocity == 0 {
                let timing = UICubicTimingParameters(animationCurve: .easeOut)
                animator.continueAnimation(withTimingParameters: timing, durationFactor: 0)
                break
            }
            
            // reverse the animations based on their current state and pan motion
            if historyViewIsOpen {
                if !shouldClose && !animator.isReversed {
                    animator.isReversed = true
                } else if shouldClose && animator.isReversed {
                    animator.isReversed = false
                }
            } else {
                if shouldClose && !animator.isReversed {
                    animator.isReversed = true
                } else if !shouldClose && animator.isReversed {
                    animator.isReversed = false
                }
            }
            
            let timing = UICubicTimingParameters(animationCurve: .easeOut)
            animator.continueAnimation(withTimingParameters: timing, durationFactor: 0)
        default:
            ()
        }
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
        
    
        diceViewCenterVerticalConstraint.constant = diceOffset
        diceViewHeightConstraint.constant = diceHeight
        historyViewHeightConstraint.constant = historyViewHeight
        panGestureViewHeightConstraint.constant = 49.0
        view.layoutIfNeeded()

    }
    
   private func animateContractHistoryView() {
        diceViewCenterVerticalConstraint.constant = -50.0
        diceViewHeightConstraint.constant = 240.0
        historyViewHeightConstraint.constant = 141.0
        panGestureViewHeightConstraint.constant = 109.0
        view.layoutIfNeeded()
    }
    
}

