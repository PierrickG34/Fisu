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

class ViewControllerMap: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private var moc : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        
        //Set the Core Data of Location
        let fr : NSFetchRequest
        fr = NSFetchRequest(entityName: "Locations")
        let result : [Location]
        do {
            result = try self.moc.executeFetchRequest(fr) as! [Location]
            if result.count > 0 {
                //Add the locations to the map
                var i = 0
                while(i < result.count) {
                    let cLocate = CLLocationCoordinate2DMake(Double(result[i].latitude!), Double(result[i].longitude!))
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = cLocate
                    annotation.title = result[i].name
                    self.mapView.addAnnotation(annotation)
                    i++
                }
            }
        }
        catch {
            print("Error when data are recovers from Locations table")
        }
    }

    
    //MARK: -  Location
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Set the zoom
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        
        self.mapView.setRegion(region, animated: false)
    }
}
