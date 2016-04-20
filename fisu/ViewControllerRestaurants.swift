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

class ViewControllerRestaurants: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    private var moc : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    private var fetchRC : NSFetchedResultsController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.title = "Restaurant"
        
        //Set the Core Data of the Locations (only restaurant)
        let fetchRequestActivities = NSFetchRequest(entityName: "Locations")
        let sd = NSSortDescriptor(key: "name", ascending: true)
        fetchRequestActivities.sortDescriptors = [sd]
        fetchRequestActivities.predicate = NSPredicate(format: "restaurant = true")
        self.fetchRC = NSFetchedResultsController(fetchRequest: fetchRequestActivities, managedObjectContext: self.moc, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchRC!.delegate = self
        do {
            try self.fetchRC!.performFetch()
        } catch {
            print("ERROR - didLoad - Fetch")
        }
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = self.fetchRC!.sections{
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        else{
            return 0
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Add the data to the table view cell based on the data in the database
        let cell = tableView.dequeueReusableCellWithIdentifier("cellRestaurant",   forIndexPath: indexPath) as! TableViewCellRestaurant
        guard let frc = self.fetchRC else{
            return cell
        }
        let location = frc.objectAtIndexPath(indexPath) as! Location
        cell.nameRestaurant.text = location.name
        return cell
    }
    
    //MARK: - Prepare For Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let index = self.tableView.indexPathForSelectedRow {
            if let destination = segue.destinationViewController as? ViewControllerDetailRestaurants {
                let location = self.fetchRC!.objectAtIndexPath(index) as! Location
                destination.location = location
            }
        }
    }

}
