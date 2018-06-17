//
//  DiceCollectionViewCell.swift
//  Dice
//
//  Created by Michael Fröhlich on 17.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit
import Spring

@IBDesignable

class DiceCollectionViewCell: UICollectionViewCell {
    
    private let diceImageView: SpringImageView = SpringImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    private func setupView() {
        
        diceImageView.contentMode = .scaleAspectFit
        
        addSubview(diceImageView)
        diceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerY = NSLayoutConstraint(item: diceImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let centerX = NSLayoutConstraint(item: diceImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let width = NSLayoutConstraint(item: diceImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let height = NSLayoutConstraint(item: diceImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        addConstraint(centerY)
        addConstraint(centerX)
        addConstraint(width)
        addConstraint(height)
    }
    
    func updateDiceImage(_ image: UIImage, animated: Bool) {
        
        if animated {
            diceImageView.animation = "pop"
            diceImageView.curve = "easeIn"
            diceImageView.force =  0.3
            diceImageView.duration =  0.7
            diceImageView.animate()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            self.diceImageView.image = image
        })
    }
}
