//
//  ViewControllerRestaurants.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 11/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import CoreData

class ViewControllerVisitMap: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var visit : Visit?
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    }
    
    //MARK: - Recuperate the segue from ViewController
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //Set location start
        let locationStart = self.visit!.start
        let cLocateStart = CLLocationCoordinate2DMake(Double(locationStart!.latitude!), Double(locationStart!.longitude!))
        var annotation = MKPointAnnotation()
        annotation.coordinate = cLocateStart
        annotation.title = self.visit!.start?.name
        self.mapView.addAnnotation(annotation)
        var region = MKCoordinateRegion(center: cLocateStart, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
        self.mapView.setRegion(region, animated: true)
        
        //Set location end
        let locationEnd = self.visit!.end
        let cLocateEnd = CLLocationCoordinate2DMake(Double(locationEnd!.latitude!), Double(locationEnd!.longitude!))
        annotation = MKPointAnnotation()
        annotation.coordinate = cLocateEnd
        annotation.title = self.visit?.end?.name
        self.mapView.addAnnotation(annotation)
        region = MKCoordinateRegion(center: cLocateEnd, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
        self.mapView.setRegion(region, animated: true)
        
        //Draw path
        self.drawLine(cLocateStart, destination: cLocateEnd)
    }
    
    //MARK: -  Location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        self.mapView.setCenterCoordinate(center, animated: false)
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
    
}
