//
//  Pug.swift
//  TakeHomeJobox
//
//  Created by marcio romero on 5/11/19.
//  Copyright © 2019 mrp. All rights reserved.
//

import UIKit

class Pug {
    
    var image: UIImage?
    var imageURL = ""
    var liked = false {
        didSet {
            if oldValue {
                likeCount = likeCount - 1
            } else {
                likeCount = likeCount + 1
            }
        }
    }
    var likeCount = Int.random(in: 0 ... 50)
    
    init(url: String) {
        self.imageURL = url
    }
}
