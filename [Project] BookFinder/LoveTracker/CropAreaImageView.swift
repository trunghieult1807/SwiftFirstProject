//
//  CropAreaImageView.swift
//  DemoAppBeenLoveMemoryLite
//
//  Created by dohien on 10/09/2018.
//  Copyright © 2018 dohien. All rights reserved.
//

import UIKit

@IBDesignable class DesignableUI: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        image()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        image()
    }
    func image() {
        self.layer.cornerRadius = UIScreen.main.bounds.width / 8
        self.layer.masksToBounds = true
    }
}

