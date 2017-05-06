//
//  RepoTableViewCell.swift
//  NickRaptisPullRequestViewer
//
//  Created by Nicholas Raptis on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLanuage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
