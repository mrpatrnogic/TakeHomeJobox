//
//  PugFeedViewController.swift
//  TakeHomeJobox
//
//  Created by marcio romero on 5/11/19.
//  Copyright © 2019 mrp. All rights reserved.
//

import UIKit

let pugFeedCellId = PugFeedCollectionViewCell.identifier()
let loadingCellId = LoadingCollectionViewCell.identifier()
let desiredPugPageSize = 50


class PugFeedViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pugData = [Pug]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
        collectionView.reloadData()
    }
    
    func requestMorePugs() {
        PugDataManager.retrievePugs(count: desiredPugPageSize, completion: { [unowned self] (dataLabel,pugs) in
            self.titleLabel.text = dataLabel.capitalized
            self.pugData.append(contentsOf: pugs)
            self.collectionView.reloadData()
        })
    }
    
    func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: pugFeedCellId, bundle: nil), forCellWithReuseIdentifier: pugFeedCellId)
        collectionView.register(UINib(nibName: loadingCellId, bundle: nil), forCellWithReuseIdentifier: loadingCellId)
    }
    
    func pugCellForIndex(_ indexPath: IndexPath) -> PugFeedCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pugFeedCellId, for: indexPath) as! PugFeedCollectionViewCell
        
        cell.pug = pugData[indexPath.row]
        
        return cell
    }
    
    func loadingCellForIndex(_ indexPath: IndexPath) -> LoadingCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loadingCellId, for: indexPath) as! LoadingCollectionViewCell
        cell.activityIndicator.startAnimating()
        return cell
    }

}

//MARK: UICollectionViewDataSource
extension PugFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pugData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row != pugData.count {
            return pugCellForIndex(indexPath)
        } else {
            requestMorePugs()
            return loadingCellForIndex(indexPath)
        }
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension PugFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let prefWidth = view.frame.size.width
        var prefHeight = prefWidth
        if indexPath.row == pugData.count {
            return CGSize(width: prefWidth, height: LoadingCollectionViewCell.prefHeight)
        }
        if let image = pugData[indexPath.row].image {
            prefHeight = prefWidth / image.imageRatio()
        }
        prefHeight = min(prefHeight,prefWidth) + PugFeedCollectionViewCell.bottomSectionHeight
        return CGSize(width: prefWidth, height: prefHeight)
    }
}
