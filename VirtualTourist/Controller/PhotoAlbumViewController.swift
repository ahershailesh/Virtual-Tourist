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
    
    var location : Location?
    let numberOfItems = 3
    let margin : CGFloat = 8
    let internalSpacing : CGFloat = 4
    
    var checkList = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self

        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteImages))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadNewImages))
        
        setToolbarItems([deleteButton,spacer, refreshButton], animated: true)
        
        self.navigationController?.isToolbarHidden = false
    }
    
    @objc func loadNewImages() {
        if let thisLocation = location {
            FlickrHandler.shared.fetchNewSet(forLocation: thisLocation, completionBlock: { [weak self] (success, response, error) in
                if success, let locationObj = response as? Location {
                    self?.location = locationObj
                }
                mainThread {
                    if success {
                        self?.collectionView?.reloadData()
                    } else {
                        self?.showAlert(message: "No new set of images are available")
                    }
                }
            })
        }
    }
    
    @objc func deleteImages() {
        let mutableSet = location?.pictureResult?.pic?.mutableCopy() as? NSMutableSet
        for indexPath in checkList {
            if let pic = location?.pictureResult?.pic?.allObjects[indexPath.row] as? Picture {
                mutableSet?.remove(pic)
            }
        }
        location?.pictureResult?.pic = mutableSet?.copy() as? NSSet
        appDelegate.coreDataStack.save()
        collectionView?.deleteItems(at: checkList)
        checkList.removeAll()
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return location?.pictureResult?.pic?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        cell.picture = location?.pictureResult?.pic?.allObjects[indexPath.row] as? Picture
        cell.isChecked = checkList.contains(indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        if checkList.contains(indexPath) {
            let index = checkList.index(of: indexPath)
            checkList.remove(at: index!)
        } else {
            checkList.append(indexPath)
        }
        cell.isChecked = checkList.contains(indexPath)
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
