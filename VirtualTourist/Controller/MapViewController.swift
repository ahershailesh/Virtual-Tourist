//
//  ViewController.swift
//  OnTheMap
//
//  Created by Shailesh Aher on 1/13/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // The map. See the setup in the Storyboard file. Note particularly that the view controller
    // is set up as the map view's delegate.
    @IBOutlet weak var mapView: MKMapView!
    var locationBlock : (() -> AnyObject)?
    var result : MapResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(foundTap(sender:)))
        singleTapRecognizer.delegate = self
        mapView.addGestureRecognizer(singleTapRecognizer)
        
        title = "Add Location"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let thisResult = getSavedMapView() else {
            return
        }
        setupRegion(model: thisResult)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveMapLocation()
    }
    
    private func setupRegion(model: MapResult) {
        result = model
        let centerCoordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(model.centerX), longitude: CLLocationDegrees(model.centerY))
        mapView.setCenter(centerCoordinate, animated: true)
        mapView.camera.altitude = CLLocationDistance(model.zoomLevel)
    }
    
    private func getSavedMapView() -> MapResult? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MapResult")
        request.fetchLimit = 1
        let objectArray = try? appDelegate.coreDataStack.context?.fetch(request)
        var mapResult : MapResult?
        if let objects =  objectArray as? [MapResult] {
            mapResult = objects.first
        }
        return mapResult
    }
    
    
    private func saveMapLocation() {
        let centerX = mapView.centerCoordinate.latitude
        let centerY = mapView.centerCoordinate.longitude
        let zoomLevel = mapView.camera.altitude
        if let thisResult = result {
            thisResult.centerX = Float(centerX)
            thisResult.centerY = Float(centerY)
            thisResult.zoomLevel = Int64(zoomLevel)
        } else {
            _ = MapResult(centerX: Float(centerX), centerY: Float(centerY), zoomLevel: Int64(zoomLevel), context: appDelegate.coreDataStack.context!)
        }
        try? appDelegate.coreDataStack.context?.save()
    }
    
    @objc func foundTap(sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        annotation.subtitle = ""
        
        let ceo = CLGeocoder()
        let loc = CLLocation(latitude: locationCoordinate.latitude, longitude:locationCoordinate.longitude)
        
        ceo.reverseGeocodeLocation(loc) { [weak self] (placemarks, error) in
            if let placemark = placemarks?.first {
                saveLog(placemark.addressDictionary)
                let name = placemark.name ?? "--"
                let city = placemark.locality ?? "--"
                annotation.title = name + ", " + city
                self?.mapView.addAnnotation(annotation)
            } else {
                self?.show(error: error)
            }
        }
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton.init(type: UIButtonType.detailDisclosure)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let albumViewController = storyboard?.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoAlbumViewController, let annotation = view.annotation {
            
            FlickrHandler.shared.getPhotoByLocation(lat: annotation.coordinate.latitude, long: annotation.coordinate.longitude, locationName: annotation.title!!, completionBlock: { [weak self] (success, response, _) in
                if success {
                    if let response = response as? Location {
                        albumViewController.location = response
                        mainThread {
                            self?.navigationController?.pushViewController(albumViewController, animated: true)
                        }
                    } else {
                        mainThread {
                            self?.showAlert(message: "This location has no pictures")
                        }
                    }
                } else {
                    saveLog("cannot able to load images")
                }
            })
        }
    }
}

extension MapViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(touch.view is MKPinAnnotationView)
    }
}
