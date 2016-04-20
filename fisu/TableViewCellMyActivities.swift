//
//  TableViewCellMyActivities.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 17/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import UIKit

class TableViewCellMyActivities: UITableViewCell {
    
    /// Description for the activity in the table view my activites
    @IBOutlet weak var activityDescriptionText: UITextView!
    
    /// Title for the activity in the table view my activites
    @IBOutlet weak var activityTitleText: UILabel!
    
    /// Date for the activity in the table view my activites
    @IBOutlet weak var activityDateText: UILabel!
    
    /// Logo for the activity in the table view my activites
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