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

class ViewControllerVisit: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var imageVisit: UIImageView!
    @IBOutlet weak var tableVisit: UITableView!
    @IBOutlet weak var titleVisit: UILabel!
    @IBOutlet weak var descriptionVisit: UITextView!
    var activity : Activity?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addMyActivities: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableVisit.delegate = self
        self.tableVisit.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = self.tableVisit.frame.height
        self.scrollView.contentSize.height = self.tableVisit.frame.origin.y + height + 20
    }
    
    //MARK: - Recuperate the segue from ViewController
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.titleVisit.text = self.activity!.name
        self.descriptionVisit.text = self.activity!.detail
        if let image = UIImage(data:(self.activity?.image)!) {
            self.imageVisit.image = image
        }
        if (self.activity!.subscribe == true) {
            self.addMyActivities.title = "Disengage"
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activity!.visited!.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellVisit",   forIndexPath: indexPath) as! TableViewCellVisit
        let index = indexPath.row
        let visit = self.activity?.visited?.allObjects as? [Visit]
        cell.titleVisit.text = visit![index].name
        cell.timeStart.text = visit![index].timeStart
        cell.imageVisit.image = UIImage(data: visit![index].photo!)
        return cell
    }
    
    //MARK: - PrepareForSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let index = self.tableVisit.indexPathForSelectedRow {
            if let destination = segue.destinationViewController as? ViewControllerVisitMap {
                let visit = self.activity?.visited?.allObjects as? [Visit]
                destination.visit = visit![index.row]
            }
        }
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
