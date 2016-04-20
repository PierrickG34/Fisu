//
//  TableViewCellVisit.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 15/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import UIKit

class TableViewCellVisit: UITableViewCell {
    
    /// Time start in the table view visit
    @IBOutlet weak var timeStart: UILabel!
    
    /// Name of the visit in the table view visit
    @IBOutlet weak var titleVisit: UILabel!
    
    /// Image in the table view visit
    @IBOutlet weak var imageVisit: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}