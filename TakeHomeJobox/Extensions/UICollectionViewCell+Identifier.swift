//
//  UICollectionViewCell+Identifier.swift
//  TakeHomeJobox
//
//  Created by marcio romero on 5/11/19.
//  Copyright © 2019 mrp. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    
    class func identifier() -> String {
        return String(describing: self)
    }
}
