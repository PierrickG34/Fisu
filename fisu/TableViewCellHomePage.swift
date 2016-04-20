//
//  TableViewCellHomePage.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 04/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import UIKit

class TableViewCellHomePage: UITableViewCell {
    
    /// Date of an activity in the table view home page
    @IBOutlet weak var activityDateText: UILabel!
    
    /// Title of an activity in the table view home page
    @IBOutlet weak var activityTitleText: UILabel!
    
    /// Description of an activity in the table view home page
    @IBOutlet weak var activityDescriptionText: UITextView!
    
    /// Logo of an activity in the table view home page
    @IBOutlet weak var presentationLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Defined only two lines for the preview
        self.activityDescriptionText.textContainer.maximumNumberOfLines = 2;
        self.activityDescriptionText.textContainer.lineBreakMode = .ByTruncatingTail;
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}