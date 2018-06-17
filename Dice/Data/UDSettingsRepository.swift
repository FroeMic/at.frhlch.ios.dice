//
//  UDSettingsRepository.swift
//  Dice
//
//  Created by Michael Fröhlich on 14.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

class UDSettingsRepository {
    
    fileprivate static let numberOfDiceKey = "numberOfDice"
    fileprivate static let shouldProvideHapticFeedbackKey = "shouldProvideHapticFeedback"
    fileprivate static let defaultSettings: Dictionary<String, String> = [
        numberOfDiceKey: "\(1)",
        shouldProvideHapticFeedbackKey: "\(true)"
    ]
    
    fileprivate let defaults = UserDefaults.standard
    
    fileprivate func isKeyPresentInUserDefaults(key: String) -> Bool {
        return defaults.object(forKey: key) != nil
    }
    
    fileprivate func getBoolOrDefault(key: String) -> Bool {
        if isKeyPresentInUserDefaults(key: key) {
            return defaults.bool(forKey: key)
        } else {
            defaults.set(UDSettingsRepository.defaultSettings[key], forKey: key)
            return defaults.bool(forKey: key)
        }
    }
    
    fileprivate func getIntOrDefault(key: String) -> Int {
        if isKeyPresentInUserDefaults(key: key) {
            return defaults.integer(forKey: UDSettingsRepository.numberOfDiceKey)
        } else {
            defaults.set(UDSettingsRepository.defaultSettings[key], forKey: key)
            return defaults.integer(forKey: key)
        }
    }
}

extension UDSettingsRepository: SettingsRepository {

    
    var numberOfDice: Int {
        get {
            return getIntOrDefault(key: UDSettingsRepository.numberOfDiceKey)
        }
        set (newValue) {
            if newValue > 0 {
                defaults.set(newValue, forKey: UDSettingsRepository.numberOfDiceKey)
            }
        }
    }
    
    var shouldProvideHapticFeedback: Bool {
        get {
            return getBoolOrDefault(key: UDSettingsRepository.shouldProvideHapticFeedbackKey)
        }
        set (newValue) {
            defaults.set(newValue, forKey: UDSettingsRepository.shouldProvideHapticFeedbackKey)
        }
    }
    
}
