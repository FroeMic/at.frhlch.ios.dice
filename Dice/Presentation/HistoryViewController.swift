//
//  HistoryViewController.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private static let showSettingSegueIdentifier = "showSettingsSegue"
    private var expanded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }
    
    private func styleView() {
        view.layer.cornerRadius = 10
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 20
        view.layer.shadowOffset = CGSize(width: 0, height: 10.0)
        view.layer.shouldRasterize = true
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        
        if expanded {
            showSettingsScene()
        } else {
            // expand and then switch to settings
        }
    }
    
    private func showSettingsScene() {
        performSegue(withIdentifier: HistoryViewController.showSettingSegueIdentifier, sender: nil)
    }
    
}
