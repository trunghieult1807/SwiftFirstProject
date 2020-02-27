 //
//  ExtensionUIimageView.swift
//  DemoAppBeenLoveMemoryLite
//
//  Created by dohien on 30/08/2018.
//  Copyright © 2018 dohien. All rights reserved.
//

import UIKit
extension UIImageView {
    func imageUrlString(urlString: String, indexpath: IndexPath) {
        guard let url = URL(string: urlString) else {return}
        DispatchQueue.global().async {
            if let data = try?  Data(contentsOf: url) { 
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
