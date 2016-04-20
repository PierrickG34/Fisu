//
//  ViewControllerDetailRestaurants.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 17/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ViewControllerDetailRestaurants: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameRestaurant: UINavigationBar!
    
    let locationManager = CLLocationManager()
    var location : Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = self.location?.name
        let cLocate = CLLocationCoordinate2DMake(Double((self.location?.latitude!)!), Double((self.location?.longitude!)!))
        let annotation = MKPointAnnotation()
        annotation.coordinate = cLocate
        annotation.title = self.location?.name
        self.mapView.addAnnotation(annotation)
    }

    //MARK: - Draw line between two location
    func drawLine(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
        // The way is for a walking person
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .Walking
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            self.mapView.addOverlay(unwrappedResponse.routes[0].polyline)
            self.mapView.setVisibleMapRect(unwrappedResponse.routes[0].polyline.boundingMapRect, animated: true)
        }
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blueColor()
        return renderer
    }
    
    
    //MARK: -  Location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Set the zoom
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        
        let currentLocation = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        self.mapView.setRegion(region, animated: false)
        let cLocate = CLLocationCoordinate2DMake(Double((self.location?.latitude)!), Double((self.location?.longitude)!))
        // Draw line between the current location of the user and the location he want to go
        self.drawLine(currentLocation, destination: cLocate)
    }

}