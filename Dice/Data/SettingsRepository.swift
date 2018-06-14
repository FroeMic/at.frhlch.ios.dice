//
//  SettingsRepository.swift
//  Dice
//
//  Created by Michael Fröhlich on 14.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import Foundation

protocol SettingsRepository {

    var shouldProvideHapticFeedback: Bool { get set }
}
