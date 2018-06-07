//
//  DiceHistoryTableViewCell.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class DiceHistoryTableViewCell: UITableViewCell {
    
    var diceResult: DiceResult? {
        didSet {
            if let diceResult = diceResult {
                updateCellContent(diceResult)
            }
        }
    }
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var imageLabel: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        styleView()
    }
    
    private func styleView() {
        containerView.layer.cornerRadius = 10
    }
    
    private func updateCellContent(_ diceResult: DiceResult) {
        imageLabel?.image = diceResult.result.image
        titleLabel?.text = "You rolled a " + diceResult.result.description
        subtitleLabel?.text = diceResult.timestamp
    }
    
    public func reloadCellContent() {
        if let diceResult = diceResult {
            updateCellContent(diceResult)
        }
    }
}
