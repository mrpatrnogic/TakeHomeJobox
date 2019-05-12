//
//  PugFeedCollectionViewCell.swift
//  TakeHomeJobox
//
//  Created by marcio romero on 5/11/19.
//  Copyright © 2019 mrp. All rights reserved.
//

import UIKit

class PugFeedCollectionViewCell: UICollectionViewCell {
    
    static let bottomSectionHeight: CGFloat = 65.0
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    var pug: Pug? {
        didSet {
            setUpView()
        }
    }
    
    @IBAction func didPressHeartButton(_ sender: UIButton) {
        guard let pug = pug else { return }
        pug.liked = !pug.liked
        updateHeartState()
    }
    
    func setUpView() {
        imageView.image = pug?.image
        updateHeartState()
    }
    
    func updateHeartState() {
        guard let pug = pug else { return }
        let buttonIcon = pug.liked ? UIImage(named: "fullHeart") : UIImage(named: "emptyHeart")
        heartButton.setImage(buttonIcon, for: .normal)
        likesLabel.text = "\(pug.likeCount) Likes"
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
}
