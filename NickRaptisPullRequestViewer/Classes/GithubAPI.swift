//
//  GithubAPI.swift
//  NickRaptisPullRequestViewer
//
//  Created by Raptis, Nicholas on 5/5/17.
//  Copyright © 2017 company_name_goes_here. All rights reserved.
//

import UIKit

//https://api.github.com/users/nraptis/repos


enum GithubNotification:String {
    case usersUpdated = "GithubNotification.usersUpdated"
    case reposUpdated = "GithubNotification.reposUpdated"
}


class GithubAPI : NSObject
{
    static let shared = GithubAPI()
    
    static var token: String {
        return "ee80354928933bd4361e2894596f73dbd26362a1"
    }
    
    static var baseURL:String {
        return "https://api.github.com/"
    }
    
    static var usersURL: String {
        return "\(baseURL)users"
    }

    var currentUser: GithubUser?
    
    var currentRepo: String {
        return ""
    }
    
    var currentPullRequest: String {
        return ""
    }
    
    
    
    
    
    //GithubUser: NSObject {
    
    //var id: Int
    //var login: String = "";
    
    
}


