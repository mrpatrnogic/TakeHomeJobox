//
//  UIImage+Size.swift
//  TakeHomeJobox
//
//  Created by marcio romero on 5/11/19.
//  Copyright © 2019 mrp. All rights reserved.
//

import UIKit

extension UIImage {
    
    func imageRatio() -> CGFloat {
        return size.width / size.height
    }
}
