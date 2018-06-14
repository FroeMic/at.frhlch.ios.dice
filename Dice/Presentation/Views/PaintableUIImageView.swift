//
//  PaintableUIImageView.swift
//  Dice
//
//  Created by Michael Fröhlich on 14.06.18.
//  Copyright © 2018 Michael Fröhlich. All rights reserved.
//

import UIKit

@IBDesignable
class PaintableUIImageView: UIImageView {
    
    @IBInspectable
    var imageColor: UIColor? {
        didSet {
            if let image = self.image {
                self.image = image.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    override var image: UIImage? {
        set (newImage) {
            super.image = newImage?.withRenderingMode(.alwaysTemplate)
        }
        get {
            return super.image
        }
    }
    
}
