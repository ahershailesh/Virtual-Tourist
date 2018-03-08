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
        
        tableView.register(UINib(nibName: "LocationListCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocation))
        navigationItem.rightBarButtonItem = rightButton
        
        title = "Saved Location"
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let location = requestHandler?.object(at: indexPath) as? Location {
            appDelegate.coreDataStack.context?.delete(location)
            appDelegate.coreDataStack.save()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Location")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "locationName", ascending: true), NSSortDescriptor(key: "createdDate", ascending: false)]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.coreDataStack.context!, sectionNameKeyPath: nil, cacheName: nil)
        requestHandler = controller
    }
    
    @objc func addLocation() {
        if let controlller = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController{
            if let locations = requestHandler?.fetchedObjects as? [Location] {
                controlller.locations = locations
            }
            navigationController?.pushViewController(controlller, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocationListCell
        if let location = requestHandler?.object(at: indexPath) as? Location {
            cell.location = location
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let location = requestHandler?.object(at: indexPath) as? Location, let pics = location.pictureResult?.pic, pics.count != 0  {
            
            if let albumViewController = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoAlbumViewController {
                albumViewController.location = location
                navigationController?.pushViewController(albumViewController, animated: true)
            }
            
        } else {
            showAlert(message: "This location has no pictures")
        }
    }
    
}
