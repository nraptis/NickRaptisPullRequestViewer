//
//  GithubPull.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class GithubPull: NSObject {
    
    var id: Int = -1
    
    var title: String = ""
    var state: String = ""
    
    var diffURL: String = ""
    
    func load(_ info: [String: AnyObject]) {
        if let _id = info["id"] as? Int {
            id = _id
        }
        if let _title = info["title"] as? String {
            title = _title
        }
        if let _state = info["state"] as? String {
            state = _state
        }
        if let _diffURL = info["diff_url"] as? String {
            diffURL = _diffURL
        }
    }
}

