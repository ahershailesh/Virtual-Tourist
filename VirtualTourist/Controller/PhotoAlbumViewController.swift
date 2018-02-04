//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 1/28/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "PhotoCell"

class PhotoAlbumViewController: UICollectionViewController {
    
    var picturesResult : PicturesResult?
    let numberOfItems = 3
    let margin : CGFloat = 8
    let internalSpacing : CGFloat = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picturesResult?.pic?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.picture = picturesResult?.pic?.allObjects[indexPath.row] as? Picture
        return cell
    }
}

extension PhotoAlbumViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let spacificWidth = (width - (2*margin + internalSpacing * CGFloat(numberOfItems - 1)))/CGFloat(numberOfItems)
        return CGSize(width: spacificWidth, height: spacificWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return internalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return internalSpacing
    }
}
