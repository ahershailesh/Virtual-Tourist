//
//  PreviousLocationController.swift
//  VirtualTourist
//
//  Created by Shailesh Aher on 2/3/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit
import CoreData

class LocationListController: TableViewController {
    
    let reuseIdentifier = "UITableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "locationName", ascending: true), NSSortDescriptor(key: "createdDate", ascending: true)]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.coreDataStack.context!, sectionNameKeyPath: nil, cacheName: nil)
        requestHandler = controller
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocation))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func addLocation() {
        if let controlller = storyboard?.instantiateViewController(withIdentifier: "MapViewController") {
            navigationController?.pushViewController(controlller, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if let location = requestHandler?.object(at: indexPath) as? Location {
            cell.textLabel?.text = location.locationName
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let location = requestHandler?.object(at: indexPath) as? Location {
            if let result = location.pictureResult {
                if let albumViewController = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoAlbumViewController {
                    albumViewController.picturesResult = result
                    navigationController?.pushViewController(albumViewController, animated: true)
                }
            }
        }
    }
    
}
