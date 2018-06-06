//
//  SettingViewController.swift
//  Dice
//
//  Created by Michael Fröhlich on 06.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }
    
    private func styleView() {
        view.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        containerView.layer.cornerRadius = 10
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 20
        containerView.layer.shadowOffset = CGSize(width: 0, height: 10.0)
        containerView.layer.shouldRasterize = true
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
