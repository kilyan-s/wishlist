//
//  RoundCornerView.swift
//  wishlist
//
//  Created by Kilyan SOCKALINGUM on 22/01/2020.
//  Copyright © 2020 Kilyan SOCKALINGUM. All rights reserved.
//

import UIKit

@IBDesignable
class RoundCornerView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 30.0
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    
    func customizeView() {
        layer.cornerRadius = cornerRadius
    }
    
}
