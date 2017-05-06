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
    
    var baseURL:String {
        return "https://api.github.com"
    }
    
    var usersURL: String {
        return "\(baseURL)/users"
    }

    var reposURL: String {
        if let user = currentUser {
            return "\(baseURL)/users/\(user.login)/repos"
        } else {
            return "\(baseURL)/users/nraptis/repos"
        }
    }
    
    var pullsURL: String {
        if let user = currentUser, let repo = currentRepo {
            return "\(baseURL)/repos/\(user.login)/\(repo.name)/pulls"
        } else {
            return "\(baseURL)/repos/nraptis/NickRaptisPullRequestViewer/pulls"
        }
    }
    
    //https://api.github.com/repos/nraptis/NickRaptisPullRequestViewer/pulls
    //https://api.github.com/users/nraptis/repos
    
    //mojombo
    
    var currentUser: GithubUser?
    
    var currentRepo: GithubRepo?
    
    var currentPullRequest: String {
        return ""
    }
    
    
    
    
    
    //GithubUser: NSObject {
    
    //var id: Int
    //var login: String = "";
    
    
}


