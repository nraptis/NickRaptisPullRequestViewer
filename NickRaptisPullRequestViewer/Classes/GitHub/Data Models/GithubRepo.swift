//
//  GithubRepo.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

class GithubRepo: NSObject {
    
    var id: Int = -1
    
    var name: String = ""
    var fullName: String = ""
    
    var language: String = ""
    
    var size: Int = 0
    
    var openIssues: Int = 0
    var starGazers: Int = 0
    var watchers: Int = 0
    
    func load(_ info: [String: AnyObject]) {
        if let _id = info["id"] as? Int {
            id = _id
        }
        if let _name = info["name"] as? String {
            name = _name
        }
        if let _fullName = info["full_name"] as? String {
            fullName = _fullName
        }
        if let _language = info["language"] as? String {
            language = _language
        }
        if let _size = info["size"] as? Int {
            size = _size
        }
        if let _openIssues = info["open_issues"] as? Int {
            openIssues = _openIssues
        }
        if let _starGazers = info["stargazers_count"] as? Int {
            starGazers = _starGazers
        }
        if let _watchers = info["watchers"] as? Int {
            watchers = _watchers
        }
    }
}
