//
//  ViewController.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 03/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var navController: UINavigationItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var moc : NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    private var fetchRC : NSFetchedResultsController? = nil
    private var factoryActivity = ActivitySet()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //Set navigation controller
        let imageView = UIImageView(frame: CGRect(x: 0, y:0, width: 40, height: 40))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(named: "fisu_logo")
        self.navController.titleView = imageView
        
        //Set the Core Data
        let fetchRequestActivities = NSFetchRequest(entityName: "Activities")
        let sd = NSSortDescriptor(key: "date", ascending: true)
        fetchRequestActivities.sortDescriptors = [sd]
        self.fetchRC = NSFetchedResultsController(fetchRequest: fetchRequestActivities, managedObjectContext: self.moc, sectionNameKeyPath: "date", cacheName: nil)
        self.fetchRC!.delegate = self
        do {
            try self.fetchRC!.performFetch()
        } catch {
            print("ERROR - didLoad - Fetch")
        }
        
        //Comment this line
        self.recordCoreData()
    }
    
    //Remove this function
    func recordCoreData() {
        let factoryLocation = LocationSet()
        let factorySpeaker = SpeakerSet()
        let factoryVisit = VisitSet()
        let df = NSDateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        var day1 : NSDate?
        day1 = df.dateFromString("02/03/2016")
        var day2: NSDate?
        day2 = df.dateFromString("03/03/2016")
        var day3: NSDate?
        day3 = df.dateFromString("04/03/2016")
        var day4: NSDate?
        day4 = df.dateFromString("05/03/2016")
        var day5: NSDate?
        day5 = df.dateFromString("06/03/2016")
        
        let loreum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus ut auctor lorem, sit amet porta diam. Phasellus eu ex sollicitudin, hendrerit nunc ut, blandit sapien. Etiam id placerat nulla. Maecenas sit amet lectus at quam dignissim feugiat. Donec magna lorem, volutpat eu erat ac, maximus porttitor augue. Integer facilisis nibh erat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur non nulla sed risus viverra porta ut in odio."
        
        
        //SET Location
        let corum = factoryLocation.newLocation("Corum", latitude: 43.6107690, longitude: 3.8767160, isRestaurant:  false)
        let law = factoryLocation.newLocation("Law Faculty", latitude: 43.6142019, longitude: 3.8763830, isRestaurant : false)
        let saint = factoryLocation.newLocation("Saint Charles", latitude: 43.6234114, longitude: 3.8721012, isRestaurant:  false)
        _ = factoryLocation.newLocation("Triolet", latitude: 43.6292129, longitude: 3.8588470, isRestaurant: true)
        _ = factoryLocation.newLocation("Rectorat", latitude: 43.6132590, longitude: 3.8769794, isRestaurant: false)
        _ = factoryLocation.newLocation("Veyrassi", latitude: 43.6410804, longitude: 3.8511707, isRestaurant: false)
        let grandeMotte = factoryLocation.newLocation("La Grande Motte", latitude: 43.5667, longitude: 4.0833, isRestaurant: false)
        let cap = factoryLocation.newLocation("Cap d'Agde", latitude: 43.2807386, longitude: 3.5053993, isRestaurant: false)
        _ = factoryLocation.newLocation("Creperie de la Comédie", latitude: 43.6085344, longitude: 3.8803476, isRestaurant: true)
        let valras = factoryLocation.newLocation("Valras plage", latitude: 43.2486680, longitude: 3.2923300, isRestaurant: false)
        _ = factoryLocation.newLocation("Creperie de la Comédie", latitude: 43.6085344, longitude: 3.8803476, isRestaurant: true)
        _ = factoryLocation.newLocation("La Piazza Papa", latitude: 43.6084401, longitude: 3.8802976, isRestaurant: true)
        _ = factoryLocation.newLocation("McDonald's", latitude: 43.6086772, longitude: 3.8793435, isRestaurant:  true)
        _ = factoryLocation.newLocation("Quick", latitude: 43.6090609, longitude: 3.8800689, isRestaurant: true)
        _ = factoryLocation.newLocation("Hotel Mercure", latitude: 43.6089093, longitude: 3.8858869, isRestaurant: false)
        
        //SET VISIT
        let visitCorum = factoryVisit.newVisit("Visite du corum", timeStart: "10 am", photo: UIImagePNGRepresentation(UIImage(named: "corum")!)!, startLocation: corum!, endLocation: law!)
        
        let visitLaw = factoryVisit.newVisit("Visite fac de droit", timeStart: "02 pm", photo: UIImagePNGRepresentation(UIImage(named: "lawFac")!)!, startLocation: law!, endLocation: saint!)
        let visitCapAgde = factoryVisit.newVisit("Plage du cap d'agde", timeStart: "09 am",photo: UIImagePNGRepresentation(UIImage(named: "plageGrande")!)!, startLocation: grandeMotte!, endLocation: cap!)
        let visitValras = factoryVisit.newVisit("Plage de Valras", timeStart: "01 pm",photo: UIImagePNGRepresentation(UIImage(named: "plageValras")!)!, startLocation: cap!, endLocation: valras!)
        
        //SET CONFERENCE
        let speaker1 = factorySpeaker.newSpeaker("Arridano", surname: "Clavet", abstract: loreum, photo: UIImagePNGRepresentation(UIImage(named: "speakerH")!)!, age: "42", email: "ArridanoC@nutrition.com", phone: "0198115709")
        let speaker2 = factorySpeaker.newSpeaker("Didier", surname: "Barrière", abstract: loreum, photo: UIImagePNGRepresentation(UIImage(named: "speakerH")!)!, age: "54", email: "DidierB@jourrapide.com", phone: "0305669340")
        let speaker3 = factorySpeaker.newSpeaker("Angelique", surname: "Joly", abstract: loreum, photo: UIImagePNGRepresentation(UIImage(named: "speakerF")!)!, age: "30", email: "JolyAng@teleworm.fr", phone: "0156999563")
        
        
        //SET Activity
        //Day 1
        let activity1 = self.factoryActivity.newActivity("Tournois de tennis", date: day1!, dateFin : day1!, detail: "Venez participer au tournoi de tennis, il est organisé par la ville de Montpellier spécialement pour vous, afin de vous divertir. N’hésitez pas à appeler l’office de tourisme afin d’obtenir plus d’informations.", typeActivity: ActivityEnum.Sport, image : UIImagePNGRepresentation(UIImage(named: "tennis-1")!)!)
        //Add location for the activity
        activity1?.located = corum
        corum?.addActivity(activity1!)
        
        let activity3 = self.factoryActivity.newActivity("Conference nutritionniste", date: day1!, dateFin : day1!, detail: "Plusieurs centres de nutrition de Montpellier se sont regroupés afin de vous parler des dangers d’une mauvaise alimentation. Au programme, pas moins de 10 programment pour bien manger. Plus d’informations sur les conférenciers ci-dessous.", typeActivity: ActivityEnum.Conference, image : UIImagePNGRepresentation(UIImage(named: "nutrition")!)!)
        //Add location for the conference
        activity3?.located = law
        law?.addActivity(activity3!)
        //Add speaker for the conference
        speaker1?.addActivity(activity3!)
        activity3?.addSpeaker(speaker1!)
        speaker2?.addActivity(activity3!)
        activity3?.addSpeaker(speaker2!)
        speaker3?.addActivity(activity3!)
        activity3?.addSpeaker(speaker3!)
        
        //Day 2
        let activity2 = self.factoryActivity.newActivity("Tournois de football", date: day2!, dateFin : day2!, detail: "Tournois de football organisé par les organisateurs du FISU. Nous vous fournissons tout, ramener simplement votre bonne humeur et votre motivation!", typeActivity: ActivityEnum.Sport, image : UIImagePNGRepresentation(UIImage(named: "football")!)!)
        //Add location for the conference
        activity2?.located = corum
        corum?.addActivity(activity2!)
        
        let activity6 = self.factoryActivity.newActivity("Petit tour à la plage", date: day2!, dateFin: day2!, detail: "Tournée des différentes plages de la région. On passera par la grande motte, le cap d'agde et valras-plage. ", typeActivity: ActivityEnum.Visit, image: UIImagePNGRepresentation(UIImage(named: "plage")!)!)
        //Add location for the visit
        activity6?.located = grandeMotte
        grandeMotte?.addActivity(activity6!)
        //Add visit
        visitCapAgde?.addActivity(activity6!)
        visitValras?.addActivity(activity6!)
        
        //Day 3
        let activity4 = self.factoryActivity.newActivity("Tournois d'handball", date: day3!, dateFin : day3!, detail: "Venez participer au tournoi d'handball, il est organisé par la ville de Montpellier spécialement pour vous, afin de vous divertir. N’hésitez pas à appeler l’office de tourisme afin d’obtenir plus d’informations.", typeActivity: ActivityEnum.Sport, image: UIImagePNGRepresentation(UIImage(named: "handball")!)!)
        
        //Day 4
        
        //Day 5
        let activity5 = self.factoryActivity.newActivity("Visite de Montpellier", date: day5!, dateFin : day5!, detail: "Nous allons ici vous faire visiter Montpellier comme vous ne l'avez encore jamais visité!", typeActivity: ActivityEnum.Visit, image: UIImagePNGRepresentation(UIImage(named: "montpellier")!)!)
        //Add location for the visit
        activity5?.located = saint
        saint?.addActivity(activity5!)
        //Add visit
        visitCorum?.addActivity(activity5!)
        visitLaw?.addActivity(activity5!)
        
        
        activity4?.located = law
        law?.addActivity(activity4!)
        

        factoryLocation.saveLocationOnCoreData()
        
        
        factoryVisit.saveLocationOnCoreData()
        
        
        
        
        
        self.factoryActivity.saveOnCoreData()
        factorySpeaker.saveOnCoreData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = self.fetchRC!.sections {
            return sections.count
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = self.fetchRC?.sections![section].name.componentsSeparatedByString(" ")[0]
        return date
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
        let cell = tableView.dequeueReusableCellWithIdentifier("myCellID",   forIndexPath: indexPath) as! TableViewCellHomePage
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
        return UITableViewCellEditingStyle.None
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // MARK: - NSFetchResultController
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
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

