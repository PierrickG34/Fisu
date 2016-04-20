//
//  ViewControllerDetailActivity.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 07/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewControllerDetailActivity: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var descriptionActivity: UITextView!
    @IBOutlet weak var TitleActivity: UILabel!
    @IBOutlet weak var imageActivity: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    var activity: Activity?
    let locationManager = CLLocationManager()
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addMyActivities: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        //self.title = self.activity?.name
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = self.mapView.frame.height
        self.scrollView.contentSize.height = self.mapView.frame.origin.y + height + 20
    }
    
    //MARK: - Recuperate the segue from ViewController
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let location = self.activity?.located
        self.TitleActivity.text = self.activity?.name
        self.descriptionActivity.text = self.activity?.detail
        if let image = UIImage(data:(self.activity?.image)!) {
            self.imageActivity.image = image
        }
        let cLocate = CLLocationCoordinate2DMake(Double(location!.latitude!), Double(location!.longitude!))
        let annotation = MKPointAnnotation()
        annotation.coordinate = cLocate
        annotation.title = location!.name
        self.mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: cLocate, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
        self.mapView.setRegion(region, animated: true)
        if (self.activity!.subscribe == true) {
            self.addMyActivities.title = "Disengage"
        }
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
        
        let currentLocation = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let desination = self.activity?.located
        let cLocate = CLLocationCoordinate2DMake(Double(desination!.latitude!), Double(desination!.longitude!))
        self.drawLine(currentLocation, destination: cLocate)
        
    }
    
    //MARK - InscriptionClicked
    @IBAction func inscriptionClicked(sender: AnyObject) {
        //Change the value of the right bottom string
        if (self.addMyActivities.title == "Participate") {
            self.activity!.subscribe = true
            self.addMyActivities.title = "Disengage"
        }
        else {
            self.activity!.subscribe = false
            self.addMyActivities.title = "Participate"
        }
    }
    
    
}
