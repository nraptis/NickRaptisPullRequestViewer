//
//  GithubDiffHunk.swift
//  NickRaptisPullRequestViewer
//
//  Created by Nicholas Raptis on 5/7/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class GithubDiffHunk: NSObject {
    
    var fromLineStart: Int = 0
    var fromLineLength: Int = 0
    
    var toLineStart: Int = 0
    var toLineLength: Int = 0
    
    var lines = [String]()
}
