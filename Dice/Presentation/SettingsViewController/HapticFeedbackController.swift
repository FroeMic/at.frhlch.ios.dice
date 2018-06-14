//
//  HapticFeedbackController.swift
//  Dice
//
//  Created by Michael Fröhlich on 14.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class HapticFeedbackController: UIViewController {
    
    private var settings = Injection.settings
    
    @IBOutlet var iconImageView: PaintableUIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var settingSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingSwitch.isOn = settings.shouldProvideHapticFeedback
    }
    
    @IBAction func didToggleSettingsButton(_ sender: UISwitch) {
        settings.shouldProvideHapticFeedback = settingSwitch.isOn
    }
}
