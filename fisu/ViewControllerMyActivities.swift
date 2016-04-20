//
//  ViewController.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 03/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerMyActivities: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var moc : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    private var fetchRC : NSFetchedResultsController? = nil
    private var factoryActivity = ActivitySet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.initializeFetchRequest()
        self.title = "My activities"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func initializeFetchRequest() {
        //Set the Core Data
        let fetchRequestActivities = NSFetchRequest(entityName: "Activities")
        let sd = NSSortDescriptor(key: "date", ascending: true)
        fetchRequestActivities.sortDescriptors = [sd]
        fetchRequestActivities.predicate = NSPredicate(format: "subscribe = true")
        self.fetchRC = NSFetchedResultsController(fetchRequest: fetchRequestActivities, managedObjectContext: self.moc, sectionNameKeyPath: "date", cacheName: nil)
        self.fetchRC!.delegate = self
        do {
            try self.fetchRC!.performFetch()
        } catch {
            print("ERROR - didLoad - Fetch")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        do {
           try self.moc.save()
        }
        catch {
            print("Error - Impossible to save")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Define the right number of section based on the data
        if let sections = self.fetchRC!.sections {
            if sections.count > 0 {
                return sections.count
            }
            else {
                return 1
            }
        }
        else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = self.fetchRC!.sections {
            if (sections.count > 0) {
                let sectionInfo = sections[section]
                if (sectionInfo.numberOfObjects > 0) {
                    let date = self.fetchRC?.sections![section].name.componentsSeparatedByString(" ")[0]
                    return date
                }
            }
            else {
                return nil
            }
        }
        return nil
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = self.fetchRC!.sections {
            if sections.count > 0 {
                let sectionInfo = sections[section]
                return sectionInfo.numberOfObjects
            }
            else {
                return 0
            }
        }
        else{
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Add the data to the table view cell based on the data in the database
        let cell = tableView.dequeueReusableCellWithIdentifier("cellMyActivities",   forIndexPath: indexPath) as! TableViewCellMyActivities
        guard let frc = self.fetchRC else{
            return cell
        }
        let activity = frc.objectAtIndexPath(indexPath) as! Activity
        cell.activityDateText.text = "\(activity.date!.description.componentsSeparatedByString(" ")[1]) - \(activity.dateFin!.description.componentsSeparatedByString(" ")[1])"
        cell.activityDescriptionText.text = activity.detail
        cell.activityTitleText.text = activity.name
        cell.presentationLogo.image = UIImage(data: activity.image!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // Add right swipe to delete
        if editingStyle == .Delete {
            if let frc = self.fetchRC {
                let activity = frc.objectAtIndexPath(indexPath) as! Activity
                activity.subscribe = false
                self.initializeFetchRequest()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - NSFetchResultController
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type{
        case .Insert:
            if let idx=newIndexPath {
                print(idx)
                self.tableView.insertRowsAtIndexPaths([idx], withRowAnimation: .Fade)
            }
        case .Delete: break
        case .Move: break
        case .Update: break
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let activity = self.fetchRC!.objectAtIndexPath(indexPath) as! Activity
        if activity.type == ActivityEnum.Conference.rawValue {
            performSegueWithIdentifier("segueConference", sender: self)
        }
        else if activity.type == ActivityEnum.Visit.rawValue {
            performSegueWithIdentifier("segueVisit", sender: self)
        }
        else {
            performSegueWithIdentifier("segueActivity", sender: self)
            
        }
    }
    
    //MARK: - PrepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Define the type of activity to go on the good view
        if let index = self.tableView.indexPathForSelectedRow {
            if segue.identifier == "segueConference" {
                if let destination = segue.destinationViewController as? ViewControllerConference {
                    let activity = self.fetchRC!.objectAtIndexPath(index) as! Activity
                    destination.activity = activity
                }
            }
            else if segue.identifier == "segueActivity" {
                if let destination = segue.destinationViewController as? ViewControllerDetailActivity {
                    let activity = self.fetchRC!.objectAtIndexPath(index) as! Activity
                    destination.activity = activity
                }
            }
            else if segue.identifier == "segueVisit" {
                if let destination = segue.destinationViewController as? ViewControllerVisit {
                    let activity = self.fetchRC!.objectAtIndexPath(index) as! Activity
                    destination.activity = activity
                }
            }
        }
    }
}

