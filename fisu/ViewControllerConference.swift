//
//  ViewControllerConference.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 09/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import MapKit

class ViewControllerConference: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var activity  : Activity?
    let locationManager = CLLocationManager()
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionActivity: UITextView!
    @IBOutlet weak var imageActivity: UIImageView!
    @IBOutlet weak var titleActivity: UILabel!
    @IBOutlet weak var addMyActivities: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
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
        self.titleActivity.text = self.activity?.name
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
        //Set zoom
        let location = locations.last
        
        let currentLocation = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let desination = self.activity?.located
        let cLocate = CLLocationCoordinate2DMake(Double(desination!.latitude!), Double(desination!.longitude!))
        
        self.drawLine(currentLocation, destination: cLocate)
        
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activity!.presented!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Add the data to the table view cell based on the data in the database
        let cell = tableView.dequeueReusableCellWithIdentifier("cellSpeaker",   forIndexPath: indexPath) as! TableViewCellSpeaker
        let index = indexPath.row
        let speaker = self.activity?.presented?.allObjects as? [Speaker]
        cell.nameSpeaker.text = speaker![index].name
        cell.surnameSpeaker.text = speaker![index].surname?.uppercaseString
        cell.abstractSpeaker.text = speaker![index].abstract
        cell.photoSpeaker.image = UIImage(data: speaker![index].photo!)
        return cell
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
    
    //MARK: - PrepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let index = self.tableView.indexPathForSelectedRow {
            if let destination = segue.destinationViewController as? ViewControllerDetailSpeaker {
                let speaker = self.activity?.presented?.allObjects as? [Speaker]
                destination.speaker = speaker![index.row]
            }
        }
    }
}
