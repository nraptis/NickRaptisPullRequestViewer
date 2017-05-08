//
//  DiffLineTableViewCell.swift
//  NickRaptisPullRequestViewer
//
//  Created by Nicholas Raptis on 5/7/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class DiffLineTableViewCell: UITableViewCell {

    @IBOutlet weak var leftBackground: UIView!
    @IBOutlet weak var rightBackground: UIView!
    
    @IBOutlet weak var leftLineNumberLabel: UILabel!
    @IBOutlet weak var rightLineNumberLabel: UILabel!
    
    @IBOutlet weak var leftLineLabel: UILabel!
    @IBOutlet weak var rightLineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
