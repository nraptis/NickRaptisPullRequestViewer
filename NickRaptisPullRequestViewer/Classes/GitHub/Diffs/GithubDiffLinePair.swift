//
//  GithubDiffLinePair.swift
//  NickRaptisPullRequestViewer
//
//  Created by Nicholas Raptis on 5/7/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class GithubDiffLinePair: NSObject {
    var leftLineNumber: Int = -1
    var leftLine: String = ""
    var rightLineNumber: Int = -1
    var rightLine: String = ""
    
    var leftHighlight: Bool = false
    var rightHighlight: Bool = false
    
}
