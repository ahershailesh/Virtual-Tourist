//
//  ViewController.swift
//  OnTheMap
//
//  Created by Shailesh Aher on 1/13/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // The map. See the setup in the Storyboard file. Note particularly that the view controller
    // is set up as the map view's delegate.
    @IBOutlet weak var mapView: MKMapView!
    var locationBlock : (() -> AnyObject)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        let singleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(foundTap(sender:)))
        singleTapRecognizer.delegate = self
        mapView.addGestureRecognizer(singleTapRecognizer)
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
                print(placemark.addressDictionary)
                let name = placemark.name ?? "--"
                let city = placemark.locality ?? "--"
                annotation.title = name + ", " + city
                self?.mapView.addAnnotation(annotation)
            }
        }
        
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
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
            
            let handler = PhotoHandler()
            handler.getPhotosByLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude, locationName: annotation.title!!, completionBlock: { [weak self] (success, response, _) in
                if success {
                    if let response = response as? PicturesResult {
                        albumViewController.picturesResult = response
                        mainThread {
                            self?.navigationController?.pushViewController(albumViewController, animated: true)
                        }
                    } else {
                        mainThread {
                            self?.showAlert(message: "This Location has no pics")
                        }
                    }
                } else {
                    print("cannot able to load images")
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
