//
//  LaunchScreenViewController.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit
import Spring

class LaunchScreenViewController: UIViewController {
    
    private static let showMainAppSegueIdentifier = "presentMainAppSegue"

    @IBOutlet var diceImageView: SpringImageView!
    @IBOutlet var titleLabel: SpringLabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        diceImageView.animation = "swing"
        diceImageView.curve = "easeIn"
        titleLabel.delay = 0.2
        diceImageView.duration =  0.6
        diceImageView.force = 0.4
        diceImageView.animate()
        
        titleLabel.animation = "zoomOut"
        titleLabel.curve = "easeIn"
        titleLabel.delay = 0.4
        titleLabel.duration =  0.8
        titleLabel.force = 1.0
        titleLabel.animate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4, execute: {
            self.performSegue(withIdentifier: LaunchScreenViewController.showMainAppSegueIdentifier, sender: nil)
        })
        
        
    }
    
}
