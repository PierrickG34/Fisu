//
//  TableViewCellSpeaker.swift
//  fisu
//
//  Created by Kevin MARGUERITTE & Pierrick GIULIANI on 10/03/2016.
//  Copyright © 2016 Kevin MARGUERITTE & Pierrick GIULIANI. All rights reserved.
//

import Foundation
import UIKit

class TableViewCellSpeaker: UITableViewCell {
    
    /// Abstract for speaker in the table view speaker
    @IBOutlet weak var abstractSpeaker: UITextView!
    
    /// Surname of the speaker in the table view speaker
    @IBOutlet weak var surnameSpeaker: UILabel!
    
    /// Name of the speaker in the table view speaker
    @IBOutlet weak var nameSpeaker: UILabel!
    
    /// Photo for the speaker in the table view speaker
    @IBOutlet weak var photoSpeaker: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Defined only two lines for the preview
        self.abstractSpeaker.textContainer.maximumNumberOfLines = 2;
        self.abstractSpeaker.textContainer.lineBreakMode = .ByTruncatingTail;
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
    