//
//  RoundedButton.swift
//  wishlist
//
//  Created by Kilyan SOCKALINGUM on 22/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    func customizeView() {
        cornerRadius = layer.frame.height / 2
        layer.cornerRadius = cornerRadius
    }
}
