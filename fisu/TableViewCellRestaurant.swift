//
//  TableViewCellRestaurant.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 17/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import UIKit

class TableViewCellRestaurant: UITableViewCell {

    /// Name for restaurant in the table view restaurant
    @IBOutlet weak var nameRestaurant: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
