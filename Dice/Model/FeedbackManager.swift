//
//  NotificatioController.swift
//  Dice
//
//  Created by Michael Fröhlich on 14.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

class FeedbackManager: NSObject  {
    
    private let notification = UINotificationFeedbackGenerator()
    private let settings = Injection.settings

    override init() {
        
    }
    
    func feedbackForDice(success: Bool = true) {
        if settings.shouldProvideHapticFeedback {
            hapticFeedback(success: success)
        }
    }
    
    private func hapticFeedback(success: Bool) {
        if success {
            notification.notificationOccurred(.success)
        } else {
            notification.notificationOccurred(.error)
        }
    }
    
}
