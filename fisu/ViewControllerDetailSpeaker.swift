//
//  ViewControllerDetailSpeaker.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 11/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerDetailSpeaker: UIViewController {
    
    @IBOutlet weak var nameSurnameSpeaker: UILabel!
    @IBOutlet weak var photoSpeaker: UIImageView!
    @IBOutlet weak var ageSpeaker: UILabel!
    @IBOutlet weak var emailSpeaker: UILabel!
    @IBOutlet weak var phoneSpeaker: UILabel!
    @IBOutlet weak var abstractSpeaker: UITextView!
    var speaker : Speaker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(speaker!.name!) \(speaker!.surname!.uppercaseString)"
    }
    
    //MARK: - Recuperate the segue from ViewControllerDetailSpeaker
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.nameSurnameSpeaker.text = speaker!.name! + " " + speaker!.surname!.uppercaseString
        self.emailSpeaker.text = speaker?.email
        self.phoneSpeaker.text = speaker?.phone
        self.abstractSpeaker.text = speaker?.abstract
        self.ageSpeaker.text = "\(speaker!.age!) ans"
        if let image = UIImage(data:(speaker?.photo)!) {
            self.photoSpeaker.image = image
        }
    }
    
}