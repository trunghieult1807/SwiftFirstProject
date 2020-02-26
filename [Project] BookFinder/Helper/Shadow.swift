//
//  Shadow.swift
//  [Project] BookFinder
//
//  Created by Apple on 2/18/20.
//  Copyright © 2020 Hieu Le. All rights reserved.
//

import UIKit
class Shadow: UIButton {
    @IBInspectable var shadowColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 100 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable var shadowOpacity: CGFloat = 109 {
        didSet {
            layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    @IBInspectable var shadowOffsetY: CGFloat = 100 {
        didSet {
            layer.shadowOffset.height = shadowOffsetY
        }
    }
}
