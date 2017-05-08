//
//  GithubDiffHunk.swift
//  NickRaptisPullRequestViewer
//
//  Created by Nicholas Raptis on 5/7/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class GithubDiffHunk: NSObject {
    var fromLine1: Int = 0
    var fromLine2: Int = 0
    
    var toLine1: Int = 0
    var toLine2: Int = 0
    
    var lines = [String]()
}
